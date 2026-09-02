/// 数据层：drift 表定义（SQLite）
///
/// 表结构参考 OpenNutriTracker / NutriTracker，精简为 4 表
library;

import 'package:drift/drift.dart';

import '../../domain/calc/nutrition_calc.dart'
    show Gender, ActivityLevel, DeficitLevel;

/// 用户档案（单行表，id 恒为 1）
class Profiles extends Table {
  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get gender => textEnum<Gender>()();
  IntColumn get birthYear => integer()();
  RealColumn get heightCm => real()();
  RealColumn get weightKg => real()();
  TextColumn get activity => textEnum<ActivityLevel>()();
  TextColumn get deficit => textEnum<DeficitLevel>()();
  RealColumn get proteinRatio => real().withDefault(const Constant(0.25))();
  RealColumn get fatRatio => real().withDefault(const Constant(0.30))();
  RealColumn get carbRatio => real().withDefault(const Constant(0.45))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// 食物库（内置《中国食物成分表》+ 用户自定义）
class Foods extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get category => text().nullable()(); // 谷薯/蔬果/肉蛋/豆奶/零食...
  RealColumn get kcalPer100g => real()(); // 每100g(可食部) kcal
  RealColumn get proteinPer100g => real().withDefault(const Constant(0))();
  RealColumn get fatPer100g => real().withDefault(const Constant(0))();
  RealColumn get carbPer100g => real().withDefault(const Constant(0))();
  TextColumn get source => text().withDefault(const Constant('custom'))(); // builtin | custom
  TextColumn get barcode => text().nullable()(); // 二期：条码扫描
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 饮食记录（每日四餐）
class Entries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()(); // 记录日（仅日期部分）
  IntColumn get mealSlot => integer()(); // 0早餐 1午餐 2晚餐 3加餐
  IntColumn get foodId => integer().nullable().references(Foods, #id)();
  TextColumn get foodName => text()(); // 冗余名称（食物可能被删）
  RealColumn get grams => real()();
  // 营养快照（按 grams 换算后的实际摄入值，防后续修改影响历史）
  RealColumn get kcal => real()();
  RealColumn get protein => real()();
  RealColumn get fat => real()();
  RealColumn get carb => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 体重日志
class WeightLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  RealColumn get weightKg => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
