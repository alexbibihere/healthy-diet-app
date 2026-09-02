/// 功能层：食物选择器 — 搜索 → 选份量 → 记入某餐
library;

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/app_database.dart';
import '../../main.dart' show dbProvider;

const kMealNames = ['早餐', '午餐', '晚餐', '加餐'];

/// 根据当前时间给个默认餐次
int defaultMealSlot() {
  final h = DateTime.now().hour;
  if (h < 10) return 0;
  if (h < 14) return 1;
  if (h < 21) return 2;
  return 3;
}

class FoodPickerSheet extends ConsumerStatefulWidget {
  const FoodPickerSheet({super.key, this.initialSlot});

  final int? initialSlot;

  @override
  ConsumerState<FoodPickerSheet> createState() => _FoodPickerSheetState();
}

class _FoodPickerSheetState extends ConsumerState<FoodPickerSheet> {
  late int _slot;
  final _controller = TextEditingController();
  final _focus = FocusNode();
  List<Food>? _results;
  Food? _picked;
  double _grams = 100;

  @override
  void initState() {
    super.initState();
    _slot = widget.initialSlot ?? defaultMealSlot();
    _controller.addListener(_onQuery);
    _focus.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _onQuery() async {
    final q = _controller.text.trim();
    if (q.isEmpty) return setState(() => _results = null);
    final list = await ref.read(dbProvider).foodDao.search(q);
    if (mounted) setState(() => _results = list);
  }

  Future<void> _addEntry() async {
    final f = _picked!;
    final scale = _grams / 100;
    await ref.read(dbProvider).entryDao.insert(
          EntriesCompanion.insert(
            date: DateTime.now(),
            mealSlot: _slot,
            foodId: Value(f.id),
            foodName: f.name,
            grams: _grams,
            kcal: f.kcalPer100g * scale,
            protein: f.proteinPer100g * scale,
            fat: f.fatPer100g * scale,
            carb: f.carbPer100g * scale,
          ),
        );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        builder: (_, __) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: _picked == null ? _buildSearch() : _buildDetail(),
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Column(
      children: [
        // 餐次选择
        SegmentedButton<int>(
          segments: [
            for (var i = 0; i < 4; i++) ButtonSegment(value: i, label: Text(kMealNames[i])),
          ],
          selected: {_slot},
          onSelectionChanged: (s) => setState(() => _slot = s.first),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _controller,
          focusNode: _focus,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: '搜索食物：鸡胸肉、苹果、燕麦…',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        if (_results != null && _results!.isEmpty)
          const Padding(padding: EdgeInsets.all(24), child: Text('没有找到，试试别的关键词～')),
        Expanded(
          child: ListView.builder(
            itemCount: _results?.length ?? 0,
            itemBuilder: (_, i) {
              final f = _results![i];
              return ListTile(
                title: Text(f.name),
                subtitle: Text(f.category ?? '自定义'),
                trailing: Text('${f.kcalPer100g.round()} kcal/100g'),
                onTap: () => setState(() {
                  _picked = f;
                  _grams = 100;
                }),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDetail() {
    final f = _picked!;
    final scale = _grams / 100;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => setState(() => _picked = null)),
            Expanded(child: Text(f.name, style: Theme.of(context).textTheme.titleLarge)),
          ],
        ),
        Text('记入：${kMealNames[_slot]}', style: TextStyle(color: scheme.primary)),
        const SizedBox(height: 12),
        // 快捷克数
        Wrap(
          spacing: 8,
          children: [
            for (final g in const [50, 100, 150, 200, 250])
              ChoiceChip(label: Text('$g g'), selected: _grams == g, onSelected: (_) => setState(() => _grams = g.toDouble())),
          ],
        ),
        Slider(
          value: _grams.clamp(10, 1000),
          min: 10,
          max: 1000,
          divisions: 99,
          label: '${_grams.round()} g',
          onChanged: (v) => setState(() => _grams = v),
        ),
        Text('份量：${_grams.round()} g', textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _nutrient('热量', '${(f.kcalPer100g * scale).round()}', 'kcal'),
                _nutrient('蛋白', '${(f.proteinPer100g * scale).round()}', 'g'),
                _nutrient('脂肪', '${(f.fatPer100g * scale).round()}', 'g'),
                _nutrient('碳水', '${(f.carbPer100g * scale).round()}', 'g'),
              ],
            ),
          ),
        ),
        const Spacer(),
        FilledButton.icon(
          onPressed: _addEntry,
          icon: const Icon(Icons.check),
          label: Text('记入${kMealNames[_slot]}'),
        ),
      ],
    );
  }

  Widget _nutrient(String label, String value, String unit) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        Text('$value $unit', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
