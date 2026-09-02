/// 功能层：饮食日记 — 按日期/餐次记录
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../food/food_picker_sheet.dart';
import '../home/home_providers.dart';
import '../../data/db/app_database.dart' show Entry;
import '../../main.dart' show dbProvider;

class DiaryPage extends ConsumerWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(selectedDateProvider);
    final entries = ref.watch(dayEntriesProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(date == _today()
            ? '今天'
            : '${date.month}月${date.day}日'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: ref.read(selectedDateProvider.notifier).prevDay,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: ref.read(selectedDateProvider.notifier).nextDay,
          ),
        ],
      ),
      body: entries.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('出错了：$e')),
        data: (list) {
          if (list.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.restaurant_menu_outlined, size: 64, color: scheme.outline),
                  const SizedBox(height: 12),
                  Text('这一天还没有记录，点 + 添加', style: TextStyle(color: scheme.onSurfaceVariant)),
                ],
              ),
            );
          }
          // 按餐次分组
          final groups = <int, List<Entry>>{};
          for (final e in list) {
            (groups[e.mealSlot] ??= []).add(e);
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
            children: [
              for (final slot in [0, 1, 2, 3])
                if (groups[slot] != null && groups[slot]!.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
                    child: Row(
                      children: [
                        Icon(_slotIcon(slot), size: 18, color: scheme.primary),
                        const SizedBox(width: 6),
                        Text(kMealNames[slot], style: Theme.of(context).textTheme.titleSmall),
                        const Spacer(),
                        Text('${groups[slot]!.fold<double>(0, (s, e) => s + e.kcal).round()} kcal',
                            style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                      ],
                    ),
                  ),
                  for (final e in groups[slot]!)
                    Card(
                      margin: const EdgeInsets.only(bottom: 6),
                      child: ListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        title: Text(e.foodName),
                        subtitle: Text('${e.grams.round()} g'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${e.kcal.round()} kcal'),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, size: 20),
                              onPressed: () => ref.read(dbProvider).entryDao.remove(e.id),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (_) => const FoodPickerSheet(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  DateTime _today() => DateTime.now();

  IconData _slotIcon(int slot) => switch (slot) {
        0 => Icons.free_breakfast_outlined,
        1 => Icons.lunch_dining_outlined,
        2 => Icons.dinner_dining_outlined,
        _ => Icons.icecream_outlined,
      };
}
