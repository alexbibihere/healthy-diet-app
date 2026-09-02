/// 数据层：AppDatabase 主类 + DAO（drift 2.31 新式写法，无 mixin）
library;

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../domain/calc/nutrition_calc.dart'
    show Gender, ActivityLevel, DeficitLevel;
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Profiles, Foods, Entries, WeightLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'litebite'));

  @override
  int get schemaVersion => 1;

  late final ProfileDao profileDao = ProfileDao(this);
  late final FoodDao foodDao = FoodDao(this);
  late final EntryDao entryDao = EntryDao(this);
  late final WeightDao weightDao = WeightDao(this);
}

// ————— Profile —————

class ProfileDao {
  ProfileDao(this._db);
  final AppDatabase _db;

  Stream<Profile?> watch() => (_db.select(_db.profiles)
        ..where((p) => p.id.equals(1)))
      .watchSingleOrNull();

  Future<Profile?> get() => (_db.select(_db.profiles)
        ..where((p) => p.id.equals(1)))
      .getSingleOrNull();

  Future<void> upsert(ProfilesCompanion entry) =>
      _db.into(_db.profiles).insertOnConflictUpdate(entry);
}

// ————— Food —————

class FoodDao {
  FoodDao(this._db);
  final AppDatabase _db;

  /// 名称模糊搜索（自定义优先）
  Future<List<Food>> search(String keyword, {int limit = 50}) {
    final q = '%$keyword%';
    return (_db.select(_db.foods)
          ..where((f) => f.name.like(q))
          ..orderBy([
            (f) => OrderingTerm(expression: f.source, mode: OrderingMode.desc),
            (f) => OrderingTerm.asc(f.name),
          ])
          ..limit(limit))
        .get();
  }

  Future<List<Food>> byCategory(String category) =>
      (_db.select(_db.foods)
            ..where((f) => f.category.equals(category))
            ..limit(200))
          .get();

  Future<int> insert(FoodsCompanion entry) => _db.into(_db.foods).insert(entry);

  Future<void> insertAllBuiltin(List<FoodsCompanion> list) =>
      _db.batch((b) => b.insertAll(_db.foods, list));

  Future<void> remove(int id) =>
      (_db.delete(_db.foods)..where((f) => f.id.equals(id))).go();
}

// ————— Entry（饮食记录）—————

class EntryDao {
  EntryDao(this._db);
  final AppDatabase _db;

  Future<List<Entry>> byDate(DateTime date) {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    return (_db.select(_db.entries)
          ..where((e) => e.date.isBetweenValues(dayStart, dayEnd))
          ..orderBy([
            (e) => OrderingTerm.asc(e.mealSlot),
            (e) => OrderingTerm.asc(e.createdAt),
          ]))
        .get();
  }

  /// 监听某天记录（Riverpod Stream 用）
  Stream<List<Entry>> watchByDate(DateTime date) {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    return (_db.select(_db.entries)
          ..where((e) => e.date.isBetweenValues(dayStart, dayEnd))
          ..orderBy([(e) => OrderingTerm.asc(e.mealSlot)]))
        .watch();
  }

  Future<int> insert(EntriesCompanion entry) => _db.into(_db.entries).insert(entry);

  Future<void> updateGrams(int id, double grams, {required Entry old}) {
    final scale = grams / old.grams;
    return (_db.update(_db.entries)..where((e) => e.id.equals(id))).write(
      EntriesCompanion(
        grams: Value(grams),
        kcal: Value(old.kcal * scale),
        protein: Value(old.protein * scale),
        fat: Value(old.fat * scale),
        carb: Value(old.carb * scale),
      ),
    );
  }

  Future<void> remove(int id) =>
      (_db.delete(_db.entries)..where((e) => e.id.equals(id))).go();
}

/// 单日营养汇总（纯计算，不落库）
class DaySummary {
  const DaySummary({
    required this.kcal,
    required this.protein,
    required this.fat,
    required this.carb,
    required this.count,
  });

  final double kcal;
  final double protein;
  final double fat;
  final double carb;
  final int count;

  static DaySummary fromEntries(List<Entry> list) => DaySummary(
        kcal: list.fold(0, (s, e) => s + e.kcal),
        protein: list.fold(0, (s, e) => s + e.protein),
        fat: list.fold(0, (s, e) => s + e.fat),
        carb: list.fold(0, (s, e) => s + e.carb),
        count: list.length,
      );

  static const empty = DaySummary(kcal: 0, protein: 0, fat: 0, carb: 0, count: 0);
}

// ————— Weight —————

class WeightDao {
  WeightDao(this._db);
  final AppDatabase _db;

  Stream<List<WeightLog>> watchAll() =>
      (_db.select(_db.weightLogs)..orderBy([(w) => OrderingTerm.asc(w.date)]))
          .watch();

  Future<void> upsertByDate(WeightLogsCompanion entry) async {
    final exist = await (_db.select(_db.weightLogs)
          ..where((w) => w.date.equals(entry.date.value)))
        .getSingleOrNull();
    if (exist == null) {
      await _db.into(_db.weightLogs).insert(entry);
    } else {
      await (_db.update(_db.weightLogs)..where((w) => w.id.equals(exist.id)))
          .write(WeightLogsCompanion(weightKg: entry.weightKg));
    }
  }
}
