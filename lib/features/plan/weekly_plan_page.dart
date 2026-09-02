/// 功能层：周食谱 — 每周/当天双视图切换 + 换菜 + 配图
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/plan/weekly_plan_repo.dart';
import 'log_to_diary.dart';
import 'recipe_detail.dart';

const kWeekdayNames = ['', '周一', '周二', '周三', '周四', '周五', '周六', '周日'];
const kSlotLabels = ['早餐', '午餐', '晚餐', '加餐'];

/// 周食谱仓库单例 Provider
final weeklyPlanRepoProvider =
    Provider<WeeklyPlanRepo>((ref) => WeeklyPlanRepo());

/// 周食谱数据 Provider（换菜后 invalidate 刷新）
final weeklyPlanProvider =
    FutureProvider.autoDispose<List<DayPlan>>((ref) async {
  return ref.watch(weeklyPlanRepoProvider).loadWeek();
});

/// 视图模式：false=每周（默认） true=当天
class PlanViewNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  void toggle() => state = !state;
}

final planViewProvider =
    NotifierProvider<PlanViewNotifier, bool>(PlanViewNotifier.new);

class WeeklyPlanPage extends ConsumerWidget {
  const WeeklyPlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(weeklyPlanProvider);
    final showToday = ref.watch(planViewProvider);
    final scheme = Theme.of(context).colorScheme;
    final today = DateTime.now().weekday;

    return Scaffold(
      appBar: AppBar(
        // 左上角：每周食谱 / 当天食谱 点击切换
        title: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => ref.read(planViewProvider.notifier).toggle(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(showToday ? '当天食谱' : '每周食谱',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 4),
                Icon(Icons.sync_alt, size: 18, color: scheme.primary),
              ],
            ),
          ),
        ),
        // 右上角：全部食谱
        actions: [
          IconButton(
            icon: const Icon(Icons.restaurant_menu),
            tooltip: '全部食谱',
            onPressed: () => context.push('/plan/all'),
          ),
        ],
      ),
      body: plans.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('出错了：$e')),
        data: (list) {
          final view = showToday
              ? list.where((d) => d.weekday == today).toList()
              : list;
          return RefreshIndicator(
            onRefresh: () => ref.refresh(weeklyPlanProvider.future),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
              itemCount: view.length,
              itemBuilder: (_, i) {
                final day = view[i];
                final isToday = day.weekday == today;
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: isToday ? scheme.primaryContainer : null,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(kWeekdayNames[day.weekday],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            if (isToday)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: scheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text('今天',
                                    style: TextStyle(
                                        color: scheme.onPrimary,
                                        fontSize: 11)),
                              ),
                            const Spacer(),
                            Text('≈${day.totalKcal} kcal',
                                style: TextStyle(
                                    color: scheme.onSurfaceVariant,
                                    fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        for (final slot in [0, 1, 2, 3])
                          if (day.meals[slot]?.isNotEmpty ?? false)
                            for (final r in day.meals[slot]!)
                              _MealTile(
                                  recipe: r,
                                  slot: slot,
                                  weekday: day.weekday),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// 单条餐目：缩略图 + 名称 + 换菜按钮
class _MealTile extends ConsumerWidget {
  const _MealTile(
      {required this.recipe, required this.slot, required this.weekday});

  final Recipe recipe;
  final int slot;
  final int weekday;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => openRecipeSheet(context, recipe),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Row(
          children: [
            RecipeThumb(recipe: recipe),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${kSlotLabels[slot]} · ${recipe.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  Text('${recipe.kcal} kcal · 蛋白${recipe.protein}g',
                      style: TextStyle(
                          fontSize: 11, color: scheme.onSurfaceVariant)),
                ],
              ),
            ),
            // 快捷：记入今日日记
            IconButton(
              icon: const Icon(Icons.edit_note, size: 20),
              tooltip: '记入今日日记',
              onPressed: () => logRecipeToDiary(context, ref, recipe),
            ),
            // 换一道
            IconButton(
              icon: const Icon(Icons.swap_horiz, size: 20),
              tooltip: '换一道',
              onPressed: () async {
                final repo = ref.read(weeklyPlanRepoProvider);
                await repo.swapNext(weekday, slot, recipe.id);
                ref.invalidate(weeklyPlanProvider);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('已换一道，再点 ⇄ 继续换'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
            Icon(Icons.chevron_right, color: scheme.outline),
          ],
        ),
      ),
    );
  }
}
