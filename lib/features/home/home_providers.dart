/// 功能层：首页 Provider（手写 Riverpod provider，不用 codegen，简单直接）
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/app_database.dart';
import '../../main.dart' show dbProvider;
import '../../domain/calc/nutrition_calc.dart';

/// 当前选中日期（默认今天）
class SelectedDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => DateTime.now();

  void set(DateTime d) => state = d;
  void prevDay() => state = state.subtract(const Duration(days: 1));
  void nextDay() => state = state.add(const Duration(days: 1));
}

final selectedDateProvider =
    NotifierProvider<SelectedDateNotifier, DateTime>(SelectedDateNotifier.new);

/// 用户档案流
final userProfileProvider = StreamProvider<UserProfile?>((ref) {
  final db = ref.watch(dbProvider);
  return db.profileDao.watch().map((p) => p == null ? null : _toDomain(p));
});

UserProfile _toDomain(Profile p) => UserProfile(
      gender: p.gender,
      age: DateTime.now().year - p.birthYear,
      heightCm: p.heightCm,
      weightKg: p.weightKg,
      activity: p.activity,
      deficit: p.deficit,
    );

/// 当日记录流
final dayEntriesProvider = StreamProvider<List<Entry>>((ref) {
  final db = ref.watch(dbProvider);
  final date = ref.watch(selectedDateProvider);
  return db.entryDao.watchByDate(date);
});

/// 当日汇总 + 目标（首页热量环数据源）
final dayProgressProvider = FutureProvider<DayProgress>((ref) async {
  final entries = await ref.watch(dayEntriesProvider.future);
  final summary = DaySummary.fromEntries(entries);
  final profile = await ref.watch(userProfileProvider.future);

  final targetKcal = profile?.dailyKcalTarget ?? 0;
  final (tp, tf, tc) = profile?.macroTargets ?? (0.0, 0.0, 0.0);

  return DayProgress(
    consumedKcal: summary.kcal,
    targetKcal: targetKcal,
    remainingKcal: targetKcal - summary.kcal,
    proteinG: summary.protein,
    proteinTargetG: tp,
    fatG: summary.fat,
    fatTargetG: tf,
    carbG: summary.carb,
    carbTargetG: tc,
  );
});

/// 首页展示模型
class DayProgress {
  const DayProgress({
    required this.consumedKcal,
    required this.targetKcal,
    required this.remainingKcal,
    required this.proteinG,
    required this.proteinTargetG,
    required this.fatG,
    required this.fatTargetG,
    required this.carbG,
    required this.carbTargetG,
  });

  final double consumedKcal;
  final int targetKcal;
  final double remainingKcal;
  final double proteinG;
  final double proteinTargetG;
  final double fatG;
  final double fatTargetG;
  final double carbG;
  final double carbTargetG;

  bool get overBudget => remainingKcal < 0;
}
