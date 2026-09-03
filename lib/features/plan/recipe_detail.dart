/// 功能层：菜谱详情弹层 + 图片组件（周食谱 / 全部食谱共用）
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/plan/recipe_image_store.dart';
import '../../data/plan/weekly_plan_repo.dart';
import 'log_to_diary.dart';
import 'weekly_plan_page.dart' show weeklyPlanRepoProvider;

/// 列表缩略图：本地 asset 优先，缺失回退 emoji 色块
class RecipeThumb extends StatelessWidget {
  const RecipeThumb({super.key, required this.recipe, this.size = 44});

  final Recipe recipe;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: size,
        height: size,
        child: Image.asset(
          recipe.imageAsset,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Container(
            color: scheme.secondaryContainer,
            alignment: Alignment.center,
            child:
                Text(recipe.emoji, style: TextStyle(fontSize: size * 0.5)),
          ),
        ),
      ),
    );
  }
}

/// 详情大图：本地文件(自定义) → 打包asset → 网络图 → emoji 渐变
class RecipeHeroImage extends StatelessWidget {
  const RecipeHeroImage({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasLocal = recipe.isCustom && recipe.imagePath != null;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: hasLocal
            ? FutureBuilder<String>(
                future: RecipeImageStore.resolvePath(recipe.imagePath!),
                builder: (ctx, snap) {
                  if (snap.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Image.file(File(snap.data!),
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _fallback(scheme));
                },
              )
            : Image.asset(
                recipe.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => recipe.imageUrl != null
                    ? Image.network(
                        recipe.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => _fallback(scheme),
                      )
                    : _fallback(scheme),
              ),
      ),
    );
  }

  Widget _fallback(ColorScheme scheme) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            scheme.primaryContainer,
            scheme.secondaryContainer,
          ]),
        ),
        alignment: Alignment.center,
        child: Text(recipe.emoji, style: const TextStyle(fontSize: 56)),
      );
}

/// 菜谱详情弹层：大图 + 营养 + 食材 + 步骤 + 贴士 + 记入日记/禁用按钮
Future<void> openRecipeSheet(BuildContext context, Recipe r) {
  final scheme = Theme.of(context).colorScheme;
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (sheetCtx) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      builder: (_, scrollCtrl) => Consumer(builder: (ctx, ref, _) {
        final repo = ref.watch(weeklyPlanRepoProvider);
        final banned = repo.isBanned(r.id);
        return ListView(
          controller: scrollCtrl,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          children: [
            RecipeHeroImage(recipe: r),
            const SizedBox(height: 12),
            Center(
              child: Text(r.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                  r.hasMacro
                      ? '${r.kcal} kcal · 蛋白 ${r.protein}g · 脂肪 ${r.fat}g · 碳水 ${r.carb}g'
                      : '${r.kcal} kcal（每份估算）',
                  style: TextStyle(
                      color: scheme.onSurfaceVariant, fontSize: 12)),
            ),
            if (banned)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: scheme.errorContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('已加入「不吃」清单，食谱中不再出现',
                        style:
                            TextStyle(color: scheme.error, fontSize: 12)),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text('🧺 食材', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            for (final ing in r.ingredients)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Expanded(child: Text(ing.n)),
                    Text(ing.g,
                        style:
                            TextStyle(color: scheme.onSurfaceVariant)),
                  ],
                ),
              ),
            const Divider(height: 28),
            Text('👨‍🍳 做法步骤',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            for (var i = 0; i < r.steps.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: scheme.primaryContainer,
                          shape: BoxShape.circle),
                      child: Text('${i + 1}',
                          style: const TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(r.steps[i])),
                  ],
                ),
              ),
            const Divider(height: 28),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: scheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('💡 '),
                  Expanded(
                      child: Text(r.tips,
                          style: const TextStyle(fontSize: 13))),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 操作按钮：记入日记 + 禁用/恢复
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: banned
                        ? null
                        : () => logRecipeToDiary(ctx, ref, r),
                    icon: const Icon(Icons.edit_note),
                    label: const Text('记入今日日记'),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        banned ? scheme.primary : scheme.error,
                  ),
                  onPressed: () async {
                    final nowBanned = await repo.toggleBanned(r.id);
                    if (ctx.mounted) {
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        SnackBar(
                          content: Text(nowBanned
                              ? '已加入「不吃」清单，食谱不再推荐 ✓'
                              : '已恢复推荐这道菜 ✓'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                      banned ? Icons.restart_alt : Icons.block,
                      size: 18),
                  label: Text(banned ? '恢复' : '不吃'),
                ),
              ],
            ),
          ],
        );
      }),
    ),
  );
}
