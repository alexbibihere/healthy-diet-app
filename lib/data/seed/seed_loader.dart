/// 内置食物数据导入（assets/json → SQLite）
library;

import 'dart:convert';

import 'package:drift/drift.dart' show Variable, Value;
import 'package:flutter/services.dart' show rootBundle;

import '../db/app_database.dart';

class SeedLoader {
  static const _seedPath = 'assets/seed/foods_builtin.json';

  /// 首次启动（或数据升级）时导入内置食物；用 shared_preferences 记录版本
  static Future<void> ensureSeeded(AppDatabase db) async {
    // 简化实现：按 source='builtin' 计数为 0 时导入
    final count = (await db.customSelect(
      'SELECT COUNT(*) AS c FROM foods WHERE source = ?',
      variables: [Variable.withString('builtin')],
    ).getSingle()).read<int>('c');

    if (count > 0) return; // 已导入

    final raw = await rootBundle.loadString(_seedPath);
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final list = (data['foods'] as List).cast<Map<String, dynamic>>();

    await db.foodDao.insertAllBuiltin([
      for (final f in list)
        FoodsCompanion.insert(
          name: f['n'] as String,
          category: Value(f['c'] as String?),
          kcalPer100g: (f['k'] as num).toDouble(),
          proteinPer100g: Value((f['p'] as num?)?.toDouble() ?? 0),
          fatPer100g: Value((f['f'] as num?)?.toDouble() ?? 0),
          carbPer100g: Value((f['cb'] as num?)?.toDouble() ?? 0),
          source: const Value('builtin'),
        ),
    ]);
  }
}
