/// 功能层：体重 — 记录 + 趋势折线
library;

import 'package:drift/drift.dart' show Value;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/app_database.dart';
import '../../main.dart' show dbProvider;

/// 体重记录流（顶层 Provider，避免 build 内联创建导致无限 loading）
final weightLogsProvider = StreamProvider<List<WeightLog>>((ref) {
  final db = ref.watch(dbProvider);
  return db.weightDao.watchAll();
});

class WeightPage extends ConsumerWidget {
  const WeightPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(weightLogsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('体重趋势')),
      body: logs.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('出错了：$e')),
        data: (list) {
          if (list.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.monitor_weight_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('还没有记录，点 + 记一下当前体重吧'),
                ],
              ),
            );
          }
          final first = list.first.weightKg;
          final last = list.last.weightKg;
          final diff = last - first;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('$last kg',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(color: Theme.of(context).colorScheme.primary)),
                      const SizedBox(height: 4),
                      Text(
                        diff == 0
                            ? '与首次记录持平'
                            : '${diff > 0 ? '+' : ''}${diff.toStringAsFixed(1)} kg（共 ${list.length} 次记录）',
                        style: TextStyle(
                          color: diff <= 0 ? Colors.green : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(child: Padding(padding: const EdgeInsets.all(12), child: _WeightChart(logs: list))),
              const SizedBox(height: 12),
              for (final w in list.reversed.take(30))
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.scale),
                  title: Text('${w.weightKg} kg'),
                  subtitle: Text('${w.date.year}-${w.date.month.toString().padLeft(2, '0')}-${w.date.day.toString().padLeft(2, '0')}'),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final ctrl = TextEditingController(text: '70.0');
    final today = DateTime.now();
    final dateCtrl = TextEditingController(
        text: '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}');

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('记录体重'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: ctrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: '体重 (kg)', suffixText: 'kg'),
              autofocus: true,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: dateCtrl,
              decoration: const InputDecoration(labelText: '日期 (yyyy-mm-dd)', suffixIcon: Icon(Icons.calendar_month)),
              readOnly: true,
              onTap: () async {
                final d = await showDatePicker(
                  context: ctx,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (d != null) {
                  dateCtrl.text = '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
            onPressed: () async {
              final kg = double.tryParse(ctrl.text);
              final parts = dateCtrl.text.split('-').map(int.parse).toList();
              if (kg == null || parts.length != 3) return;
              await ref.read(dbProvider).weightDao.upsertByDate(
                    WeightLogsCompanion.insert(
                      date: DateTime(parts[0], parts[1], parts[2]),
                      weightKg: kg,
                    ),
                  );
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }
}

class _WeightChart extends StatelessWidget {
  const _WeightChart({required this.logs});

  final List<WeightLog> logs;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final spots = <FlSpot>[
      for (var i = 0; i < logs.length; i++)
        FlSpot(i.toDouble(), logs[i].weightKg),
    ];
    final values = logs.map((l) => l.weightKg).toList();
    final minV = values.reduce((a, b) => a < b ? a : b);
    final maxV = values.reduce((a, b) => a > b ? a : b);
    final pad = (maxV - minV).clamp(0.5, 10);

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          minY: minV - pad * 0.2,
          maxY: maxV + pad * 0.2,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: pad / 2,
            getDrawingHorizontalLine: (v) => FlLine(color: scheme.outlineVariant, strokeWidth: 0.5),
          ),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: pad / 2,
                getTitlesWidget: (v, _) => Text(v.toStringAsFixed(1),
                    style: TextStyle(fontSize: 10, color: scheme.onSurfaceVariant)),
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              preventCurveOverShooting: true,
              color: scheme.primary,
              barWidth: 2.5,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: scheme.primary.withValues(alpha: 0.08),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// （dateOnly 扩展已移除：日期规整统一在 DAO 层完成）
// ignore: unused_element
final _ = Value; // 保持 drift Value import 供未来扩展使用
