/// 功能层：全部食谱 — 搜索 + 餐次筛选 + 左滑禁用（不吃）
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/plan/weekly_plan_repo.dart';
import 'add_recipe_sheet.dart';
import 'log_to_diary.dart';
import 'recipe_detail.dart';
import 'weekly_plan_page.dart' show weeklyPlanRepoProvider;

class AllRecipesPage extends ConsumerStatefulWidget {
  const AllRecipesPage({super.key});

  @override
  ConsumerState<AllRecipesPage> createState() => _AllRecipesPageState();
}

class _AllRecipesPageState extends ConsumerState<AllRecipesPage> {
  String _query = '';
  int _filter = -1; // -1 全部 / 0早 1午 2晚 3加餐 / -2 已禁用 / -3 减脂主推
  static const _bannedFilter = -2;
  static const _greenFilter = -3;

  /// 拉全量菜谱（含 howtocook 扩充池）
  Future<List<Recipe>> _loadAll(WeeklyPlanRepo repo) async {
    await repo.loadWeek();
    return repo.allRecipes;
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(weeklyPlanRepoProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('全部食谱'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: '添加自定义菜谱',
            onPressed: () => showAddRecipeSheet(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // 搜索框
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: TextField(
              decoration: InputDecoration(
                hintText: '搜索菜名…',
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (v) => setState(() => _query = v.trim()),
            ),
          ),
          // 餐次筛选 chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                for (final f in const [
                  (-1, '全部'),
                  (-3, '🟢 主推'),
                  (0, '早餐'),
                  (1, '午餐'),
                  (2, '晚餐'),
                  (3, '加餐'),
                  (-2, '🚫 已禁用'),
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(f.$2),
                      selected: _filter == f.$1,
                      showCheckmark: false,
                      onSelected: (_) => setState(() => _filter = f.$1),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Recipe>>(
              future: _loadAll(repo),
              builder: (context, snap) {
                if (snap.hasError) {
                  return Center(child: Text('加载失败：${snap.error}'));
                }
                if (!snap.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final all = snap.data!;
                final bannedIds = repo.bannedIds;
                final q = _query.toLowerCase();
                final list = all.where((r) {
                  final isBanned = bannedIds.contains(r.id);
                  final okFilter = switch (_filter) {
                    _bannedFilter => isBanned,
                    _greenFilter => !isBanned && r.tier == 'green',
                    -1 => true,
                    _ => !isBanned && r.slots.contains(_filter),
                  };
                  final okQuery =
                      q.isEmpty || r.name.toLowerCase().contains(q);
                  return okFilter && okQuery;
                }).toList()
                  ..sort((a, b) => a.name.compareTo(b.name));

                if (list.isEmpty) {
                  return Center(
                    child: Text(
                        _filter == _bannedFilter
                            ? '没有禁用的菜谱～\n在「全部」里左滑任意菜即可禁用'
                            : '没有找到匹配的菜谱～',
                        textAlign: TextAlign.center),
                  );
                }
                // 标题后跟当前筛选下的数量，如「全部食谱 · 134」
                final countText = switch (_filter) {
                  _bannedFilter => '已禁用 · ${list.length}',
                  _greenFilter => '减脂主推 · ${list.length}',
                  -1 => '全部 · ${list.length}',
                  _ => '${kSlotShort[_filter]} · ${list.length}',
                };
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(countText,
                            style: TextStyle(
                                fontSize: 12,
                                color: scheme.onSurfaceVariant)),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        itemCount: list.length,
                        itemBuilder: (_, i) {
                          final r = list[i];
                          final isBanned = bannedIds.contains(r.id);
                          final slotText = r.slots
                              .map((s) => kSlotShort[s])
                              .whereType<String>()
                              .join(' / ');
                          return _recipeCard(context, ref, repo, r, isBanned,
                              slotText, scheme);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _swipeBg(
    ColorScheme scheme, {
    required bool alignLeft,
    required IconData icon,
    required String label,
    required Color color,
    required Color fg,
  }) {
    final content = Row(
      mainAxisAlignment:
          alignLeft ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!alignLeft) const SizedBox(width: 24),
        Icon(icon, color: fg),
        const SizedBox(width: 6),
        Text(label,
            style: TextStyle(
                color: fg, fontWeight: FontWeight.bold, fontSize: 13)),
        if (alignLeft) const SizedBox(width: 24),
      ],
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: content,
    );
  }

  /// 单个菜谱卡片：左滑禁用/恢复
  Widget _recipeCard(
      BuildContext context,
      WidgetRef ref,
      WeeklyPlanRepo repo,
      Recipe r,
      bool isBanned,
      String slotText,
      ColorScheme scheme) {
    return Dismissible(
      key: ValueKey(r.id),
      direction: DismissDirection.horizontal,
      background: _swipeBg(
        scheme,
        alignLeft: false,
        icon: Icons.block,
        label: '不吃',
        color: scheme.errorContainer,
        fg: scheme.error,
      ),
      secondaryBackground: _swipeBg(
        scheme,
        alignLeft: true,
        icon: Icons.block,
        label: '不吃',
        color: scheme.errorContainer,
        fg: scheme.error,
      ),
      confirmDismiss: (_) async {
        // 不真正移除卡片：就地切换禁用状态并刷新
        final nowBanned = await repo.toggleBanned(r.id);
        setState(() {});
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(nowBanned
                  ? '「${r.name}」已禁用，周食谱不再推荐'
                  : '「${r.name}」已恢复推荐'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
        return false;
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        color: isBanned ? scheme.surfaceContainerHighest : null,
        child: ListTile(
          leading: Opacity(
            opacity: isBanned ? 0.4 : 1,
            child: RecipeThumb(recipe: r),
          ),
          title: Text(
            isBanned ? '${r.name}（已禁用）' : r.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              decoration: isBanned ? TextDecoration.lineThrough : null,
              color: isBanned ? scheme.onSurfaceVariant : null,
            ),
          ),
          subtitle: Row(
            children: [
              // 减脂指数色点
              Container(
                width: 8, height: 8,
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  color: tierColor(r.tier),
                  shape: BoxShape.circle,
                ),
              ),
              Flexible(
                child: Text(
                  isBanned ? '左滑恢复 · $slotText' : '$slotText · ${r.kcal} kcal',
                  style: TextStyle(
                      fontSize: 12,
                      color: scheme.onSurfaceVariant),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit_note,
                  size: 20,
                  color:
                      isBanned ? scheme.onSurfaceVariant : scheme.primary,
                ),
                tooltip: '记入今日日记',
                onPressed: () => logRecipeToDiary(context, ref, r),
              ),
              const Icon(Icons.chevron_right, size: 20),
            ],
          ),
          onTap: () => openRecipeSheet(context, r),
        ),
      ),
    );
  }
}

const kSlotShort = {0: '早餐', 1: '午餐', 2: '晚餐', 3: '加餐'};

/// 减脂指数 → 颜色（绿/黄/橙）
Color tierColor(String tier) => switch (tier) {
      'green' => const Color(0xFF2E7D32),
      'orange' => const Color(0xFFEF6C00),
      _ => const Color(0xFFF9A825),
    };
