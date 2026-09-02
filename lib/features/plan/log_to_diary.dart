/// 功能层：菜谱 → 记入今日日记
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/app_database.dart';
import '../../data/plan/weekly_plan_repo.dart';
import '../../main.dart' show dbProvider;

/// 按当前时段推断餐次：<11 早餐 / <16 午餐 / <21 晚餐 / 其余加餐
int guessMealSlot(DateTime now) {
  final h = now.hour;
  if (h < 11) return 0;
  if (h < 16) return 1;
  if (h < 21) return 2;
  return 3;
}

const kSlotNames = ['早餐', '午餐', '晚餐', '加餐'];

/// 详情弹层底部按钮：把整道菜按当前时段记入今日日记
Future<void> logRecipeToDiary(BuildContext context, WidgetRef ref, Recipe r) {
  final slot = guessMealSlot(DateTime.now());

  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetCtx) => _LogSheet(recipe: r, initialSlot: slot),
  );
}

class _LogSheet extends ConsumerStatefulWidget {
  const _LogSheet({required this.recipe, required this.initialSlot});

  final Recipe recipe;
  final int initialSlot;

  @override
  ConsumerState<_LogSheet> createState() => _LogSheetState();
}

class _LogSheetState extends ConsumerState<_LogSheet> {
  late int _slot = widget.initialSlot;
  bool _saving = false;

  Future<void> _save() async {
    setState(() => _saving = true);
    final r = widget.recipe;
    await ref.read(dbProvider).entryDao.insert(
          EntriesCompanion.insert(
            date: DateTime.now(),
            mealSlot: _slot,
            // 食谱菜无对应 foods 行，foodId 留空，名称冗余存储
            foodName: r.name,
            grams: 0,
            kcal: r.kcal.toDouble(),
            protein: r.protein.toDouble(),
            fat: r.fat.toDouble(),
            carb: r.carb.toDouble(),
          ),
        );
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('已记入今日${kSlotNames[_slot]}：${r.name} ✓'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('记入今日日记',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(widget.recipe.name,
                style:
                    TextStyle(color: scheme.onSurfaceVariant, fontSize: 13)),
            const SizedBox(height: 16),
            // 餐次选择
            SegmentedButton<int>(
              segments: [
                for (var i = 0; i < 4; i++)
                  ButtonSegment(value: i, label: Text(kSlotNames[i])),
              ],
              selected: {_slot},
              onSelectionChanged: (s) => setState(() => _slot = s.first),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.check),
              label: Text(_saving ? '记录中…' : '确认记录'),
            ),
          ],
        ),
      ),
    );
  }
}
