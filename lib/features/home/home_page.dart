/// 功能层：首页 — 今日仪表盘
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'home_providers.dart';
import 'widgets/calorie_ring.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(dayProgressProvider);
    final profile = ref.watch(userProfileProvider);
    final scheme = Theme.of(context).colorScheme;

    // 未建档：引导
    return profile.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('出错了：$e'))),
      data: (p) => p == null
          ? Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.eco_outlined, size: 72, color: scheme.primary),
                      const SizedBox(height: 16),
                      Text('欢迎使用轻食记', style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      Text('先花 30 秒填写身体数据，\n我会帮你算出每日饮食目标～',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: scheme.onSurfaceVariant)),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: () => context.go('/onboarding'),
                        icon: const Icon(Icons.rocket_launch),
                        label: const Text('开始设置'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text('轻食记 · ${_greeting()}'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.tune),
                    tooltip: '重新设置身体数据',
                    onPressed: () => context.go('/onboarding'),
                  ),
                ],
              ),
              body: progress.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('出错了：$e')),
                data: (pr) => ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            CalorieRing(progress: pr),
                            const SizedBox(height: 12),
                            MacroBars(progress: pr),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // 本周食谱入口
                    Card(
                      child: ListTile(
                        leading: const Text('🥗', style: TextStyle(fontSize: 28)),
                        title: const Text('本周食谱'),
                        subtitle: const Text('每天吃什么 · 怎么做 · 带步骤和贴士'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.go('/plan'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // 今日记录摘要（按餐次）
                    ref.watch(dayEntriesProvider).maybeWhen(
                          data: (entries) => entries.isEmpty
                              ? Card(
                                  child: ListTile(
                                    leading: const Icon(Icons.restaurant_menu),
                                    title: const Text('今天还没有记录'),
                                    subtitle: const Text('去「日记」页添加你吃的东西吧～'),
                                    onTap: () => context.go('/diary'),
                                  ),
                                )
                              : Column(
                                  children: [
                                    for (final g in _groupBySlot(entries))
                                      Card(
                                        child: ListTile(
                                          leading: Icon(_slotIcon(g.$1)),
                                          title: Text(_mealName(g.$1)),
                                          trailing: Text('${g.$2.round()} kcal',
                                              style: Theme.of(context).textTheme.titleSmall),
                                          onTap: () => context.go('/diary'),
                                        ),
                                      ),
                                  ],
                                ),
                          orElse: () => const SizedBox.shrink(),
                        ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () => context.go('/diary'),
                icon: const Icon(Icons.add),
                label: const Text('记一笔'),
              ),
            ),
    );
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 11) return '早上好';
    if (h < 14) return '中午好';
    if (h < 18) return '下午好';
    return '晚上好';
  }

  List<(int, double)> _groupBySlot(List<dynamic> entries) {
    final sums = List<double>.filled(4, 0);
    for (final e in entries) {
      sums[e.mealSlot as int] += e.kcal as double;
    }
    return [
      for (var i = 0; i < 4; i++)
        if (sums[i] > 0) (i, sums[i]),
    ];
  }

  String _mealName(int slot) =>
      switch (slot) { 0 => '早餐', 1 => '午餐', 2 => '晚餐', _ => '加餐' };

  IconData _slotIcon(int slot) => switch (slot) {
        0 => Icons.free_breakfast_outlined,
        1 => Icons.lunch_dining_outlined,
        2 => Icons.dinner_dining_outlined,
        _ => Icons.icecream_outlined,
      };
}
