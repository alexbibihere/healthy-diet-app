/// 应用入口
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'data/db/app_database.dart';
import 'data/seed/seed_loader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();
  await SeedLoader.ensureSeeded(db); // 首次启动导入内置食物库

  runApp(
    ProviderScope(
      overrides: [
        dbProvider.overrideWithValue(db),
      ],
      child: const LiteBiteApp(),
    ),
  );
}

/// 全局数据库 Provider（main 里 override）
final dbProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('must be overridden in main()');
});
