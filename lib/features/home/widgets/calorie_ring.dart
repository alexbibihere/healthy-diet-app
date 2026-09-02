/// 功能层：首页 — 热量环 + 三大宏量进度条
library;

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../home_providers.dart';

/// 热量环：中间大字显示剩余可吃热量，环上显示 已吃/目标
class CalorieRing extends StatelessWidget {
  const CalorieRing({super.key, required this.progress});

  final DayProgress progress;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final pct = progress.targetKcal == 0
        ? 0.0
        : (progress.consumedKcal / progress.targetKcal).clamp(0.0, 1.0);
    final remaining = progress.remainingKcal.round();

    return SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 78,
              startDegreeOffset: 270,
              sections: [
                PieChartSectionData(
                  value: pct == 0 ? 1 : pct,
                  radius: 16,
                  color: progress.overBudget ? scheme.error : scheme.primary,
                ),
                if (pct > 0 && pct < 1)
                  PieChartSectionData(
                    value: 1 - pct,
                    radius: 16,
                    color: scheme.surfaceContainerHighest,
                  ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                progress.overBudget ? '已超支' : '还可吃',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: progress.overBudget ? scheme.error : scheme.onSurfaceVariant,
                    ),
              ),
              Text(
                '$remaining',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: progress.overBudget ? scheme.error : scheme.onSurface,
                    ),
              ),
              const Text('kcal', style: TextStyle(fontSize: 12)),
              const SizedBox(height: 4),
              Text(
                '${progress.consumedKcal.round()} / ${progress.targetKcal}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 三大宏量进度条（蛋白/脂肪/碳水）
class MacroBars extends StatelessWidget {
  const MacroBars({super.key, required this.progress});

  final DayProgress progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _bar(context, '蛋白质', progress.proteinG, progress.proteinTargetG, Colors.red.shade300)),
        Expanded(child: _bar(context, '脂肪', progress.fatG, progress.fatTargetG, Colors.amber.shade600)),
        Expanded(child: _bar(context, '碳水', progress.carbG, progress.carbTargetG, Colors.blue.shade300)),
      ],
    );
  }

  Widget _bar(BuildContext context, String label, double value, double target, Color color) {
    final scheme = Theme.of(context).colorScheme;
    final pct = target <= 0 ? 0.0 : (value / target).clamp(0.0, 1.0);
    return Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: pct),
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          builder: (c, v, _) => LinearProgressIndicator(
            value: v,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
            backgroundColor: scheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        Text(
          '${value.round()}/${target.round()}g',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
