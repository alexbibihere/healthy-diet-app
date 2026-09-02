/// 功能层：首次建档引导 — 收集身体数据 → 算出每日目标
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/db/app_database.dart';
import '../../domain/calc/nutrition_calc.dart';
import '../../main.dart' show dbProvider;

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _formKey = GlobalKey<FormState>();

  Gender _gender = Gender.male;
  int _birthYear = DateTime.now().year - 25;
  double _heightCm = 172;
  double _weightKg = 70;
  ActivityLevel _activity = ActivityLevel.light;
  DeficitLevel _deficit = DeficitLevel.standard;

  UserProfile get _preview => UserProfile(
        gender: _gender,
        age: DateTime.now().year - _birthYear,
        heightCm: _heightCm,
        weightKg: _weightKg,
        activity: _activity,
        deficit: _deficit,
      );

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(dbProvider).profileDao.upsert(
          ProfilesCompanion.insert(
            gender: _gender,
            birthYear: _birthYear,
            heightCm: _heightCm,
            weightKg: _weightKg,
            activity: _activity,
            deficit: _deficit,
          ),
        );
    if (mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final p = _preview;
    final (tg, tf, tc) = p.macroTargets;

    return Scaffold(
      appBar: AppBar(title: const Text('欢迎来到轻食记')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('花 30 秒填一下身体数据，帮你算出每日饮食目标～',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),

            // 性别
            SegmentedButton<Gender>(
              segments: const [
                ButtonSegment(value: Gender.male, label: Text('男'), icon: Icon(Icons.male)),
                ButtonSegment(value: Gender.female, label: Text('女'), icon: Icon(Icons.female)),
              ],
              selected: {_gender},
              onSelectionChanged: (s) => setState(() => _gender = s.first),
            ),
            const SizedBox(height: 16),

            // 出生年
            DropdownMenu<int>(
              initialSelection: _birthYear,
              label: const Text('出生年份'),
              onSelected: (v) => setState(() => _birthYear = v ?? _birthYear),
              dropdownMenuEntries: [
                for (var y = DateTime.now().year - 15; y >= DateTime.now().year - 80; y--)
                  DropdownMenuEntry(value: y, label: '$y 年'),
              ],
            ),
            const SizedBox(height: 16),

            // 身高
            _sliderTile('身高', _heightCm, 130, 220, ' cm'),
            // 体重
            _sliderTile('体重', _weightKg, 35, 150, ' kg', step: 0.5),

            // 活动水平
            Text('日常活动量', style: Theme.of(context).textTheme.titleSmall),
            for (final a in ActivityLevel.values)
              RadioListTile(
                value: a,
                groupValue: _activity,
                title: Text(a.label),
                contentPadding: EdgeInsets.zero,
                dense: true,
                onChanged: (v) => setState(() => _activity = v!),
              ),
            Text('减脂速度', style: Theme.of(context).textTheme.titleSmall),
            for (final d in DeficitLevel.values)
              RadioListTile(
                value: d,
                groupValue: _deficit,
                title: Text(d.label),
                contentPadding: EdgeInsets.zero,
                dense: true,
                onChanged: (v) => setState(() => _deficit = v!),
              ),
            const SizedBox(height: 8),

            // 实时预览
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('你的每日目标', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text('${p.dailyKcalTarget} kcal',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary)),
                    const SizedBox(height: 4),
                    Text('蛋白 ${tg.round()}g · 脂肪 ${tf.round()}g · 碳水 ${tc.round()}g',
                        style: Theme.of(context).textTheme.bodySmall),
                    Text('BMI ${p.bmi.toStringAsFixed(1)}（${p.bmiLabel}）',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.rocket_launch),
              label: const Text('开始我的减脂之旅'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sliderTile(String label, double value, double min, double max, String unit, {double step = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleSmall),
            Text('${step == 1 ? value.round() : value} $unit'),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: ((max - min) / step).round(),
          label: '${step == 1 ? value.round() : value} $unit',
          onChanged: (v) => setState(() => step == 1 ? _setInt(label, v) : _setDouble(label, v)),
        ),
      ],
    );
  }

  void _setInt(String label, double v) {
    if (label == '身高') _heightCm = v.roundToDouble();
    if (label == '体重') _weightKg = v.roundToDouble();
  }

  void _setDouble(String label, double v) {
    if (label == '体重') _weightKg = (v * 2).roundToDouble() / 2; // 0.5 步进
  }
}
