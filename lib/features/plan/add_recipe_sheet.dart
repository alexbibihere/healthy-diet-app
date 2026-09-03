/// 功能层：添加自定义菜谱（表单弹层）
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/plan/recipe_image_store.dart';
import '../../data/plan/weekly_plan_repo.dart';
import 'recipe_detail.dart';
import 'weekly_plan_page.dart' show weeklyPlanProvider, weeklyPlanRepoProvider;

const kSlotNames = ['早餐', '午餐', '晚餐', '加餐'];
const kEmojis = ['🥗', '🍗', '🐟', '🍲', '🍚', '🍳', '🥣', '🍝', '🥟', '🍎', '🥤', '🍠'];

/// 打开「添加自定义菜谱」表单
Future<void> showAddRecipeSheet(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => const _AddRecipeSheet(),
  );
}

class _AddRecipeSheet extends ConsumerStatefulWidget {
  const _AddRecipeSheet();

  @override
  ConsumerState<_AddRecipeSheet> createState() => _AddRecipeSheetState();
}

class _AddRecipeSheetState extends ConsumerState<_AddRecipeSheet> {
  final _nameCtrl = TextEditingController();
  final _kcalCtrl = TextEditingController();
  final _ingNameCtrl = TextEditingController();
  final _ingGramCtrl = TextEditingController();
  final _stepCtrl = TextEditingController();
  final _tipsCtrl = TextEditingController();

  String _emoji = '🥗';
  final Set<int> _slots = {1};
  final List<({String n, String g})> _ingredients = [];
  final List<String> _steps = [];
  XFile? _image;

  bool get _canSave =>
      _nameCtrl.text.trim().isNotEmpty &&
      int.tryParse(_kcalCtrl.text) != null &&
      _ingredients.isNotEmpty &&
      _steps.isNotEmpty;

  void _addIngredient() {
    final n = _ingNameCtrl.text.trim();
    if (n.isEmpty) return;
    setState(() {
      _ingredients.add((n: n, g: _ingGramCtrl.text.trim()));
      _ingNameCtrl.clear();
      _ingGramCtrl.clear();
    });
  }

  void _addStep() {
    final s = _stepCtrl.text.trim();
    if (s.isEmpty) return;
    setState(() {
      _steps.add(s);
      _stepCtrl.clear();
    });
  }

  Future<void> _save() async {
    // 先落图片文件（若有）
    String? imageFileName;
    if (_image != null) {
      final seed = DateTime.now().millisecondsSinceEpoch.toString();
      final saved = await RecipeImageStore.saveRecipeImage(_image!, seed);
      imageFileName = saved.fileName;
    }
    final repo = ref.read(weeklyPlanRepoProvider);
    final id = await repo.addCustomRecipe(
      Recipe(
        id: '',
        name: _nameCtrl.text.trim(),
        emoji: _emoji,
        kcal: int.parse(_kcalCtrl.text),
        protein: 0,
        fat: 0,
        carb: 0,
        ingredients: List.of(_ingredients),
        steps: List.of(_steps),
        tips: _tipsCtrl.text.trim().isEmpty ? '我的自定义菜谱' : _tipsCtrl.text.trim(),
        slots: _slots.isEmpty ? const [1] : _slots.toList(),
      ),
      imageFileName: imageFileName,
    );
    // 刷新所有依赖菜谱池的页面
    ref.invalidate(weeklyPlanProvider);
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('「${_nameCtrl.text.trim()}」已加入菜谱池 ✓ 可在周食谱里换到它'),
          duration: const Duration(seconds: 3),
        ),
      );
      // 打开刚建的菜谱详情给用户确认
      final all = repo.allRecipes;
      final created = all.firstWhere((r) => r.id == id);
      openRecipeSheet(context, created);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _kcalCtrl.dispose();
    _ingNameCtrl.dispose();
    _ingGramCtrl.dispose();
    _stepCtrl.dispose();
    _tipsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.92,
        builder: (_, scrollCtrl) => ListView(
          controller: scrollCtrl,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          children: [
            Text('添加自定义菜谱',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // 菜名
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: '菜名 *',
                hintText: '例如：妈妈牌凉拌鸡胸',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            // 图片（可选）：拍照 或 相册
            Text('📷 图片（可选）', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            Row(
              children: [
                // 预览
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 72,
                    height: 72,
                    color: scheme.surfaceContainerHighest,
                    child: _image != null
                        ? Image.file(File(_image!.path), fit: BoxFit.cover)
                        : const Icon(Icons.image_outlined, size: 32),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: () async {
                    final x = await RecipeImageStore.takePhoto();
                    if (x != null) setState(() => _image = x);
                  },
                  icon: const Icon(Icons.photo_camera_outlined, size: 18),
                  label: const Text('拍照'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () async {
                    final x = await RecipeImageStore.pickFromGallery();
                    if (x != null) setState(() => _image = x);
                  },
                  icon: const Icon(Icons.photo_outlined, size: 18),
                  label: const Text('相册'),
                ),
                if (_image != null)
                  IconButton(
                    tooltip: '移除图片',
                    onPressed: () => setState(() => _image = null),
                    icon: const Icon(Icons.close, size: 18),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // emoji 选择
            Text('图标', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: [
                for (final e in kEmojis)
                  ChoiceChip(
                    label: Text(e, style: const TextStyle(fontSize: 18)),
                    selected: _emoji == e,
                    showCheckmark: false,
                    onSelected: (_) => setState(() => _emoji = e),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // 热量
            TextField(
              controller: _kcalCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '整份热量 (kcal) *',
                hintText: '估算即可，例如 350',
                border: OutlineInputBorder(),
                suffixText: 'kcal',
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),

            // 适合餐次
            Text('适合餐次 *', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: [
                for (var i = 0; i < 4; i++)
                  FilterChip(
                    label: Text(kSlotNames[i]),
                    selected: _slots.contains(i),
                    showCheckmark: false,
                    onSelected: (on) => setState(() {
                      on ? _slots.add(i) : _slots.remove(i);
                    }),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // 食材
            Text('🧺 食材 *（逐条添加）',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _ingNameCtrl,
                    decoration: const InputDecoration(
                      hintText: '名称，如 鸡胸肉',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addIngredient(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _ingGramCtrl,
                    decoration: const InputDecoration(
                      hintText: '份量，如 150g',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addIngredient(),
                  ),
                ),
                IconButton(
                  onPressed: _addIngredient,
                  icon: const Icon(Icons.add_circle),
                  color: scheme.primary,
                  tooltip: '添加食材',
                ),
              ],
            ),
            if (_ingredients.isNotEmpty) ...[
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (var i = 0; i < _ingredients.length; i++)
                    InputChip(
                      label: Text(
                          '${_ingredients[i].n} ${_ingredients[i].g}'),
                      onDeleted: () =>
                          setState(() => _ingredients.removeAt(i)),
                    ),
                ],
              ),
            ],
            const SizedBox(height: 16),

            // 步骤
            Text('👨‍🍳 做法步骤 *（逐条添加）',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _stepCtrl,
                    maxLines: 2,
                    minLines: 1,
                    decoration: const InputDecoration(
                      hintText: '一句话写一步',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addStep(),
                  ),
                ),
                IconButton(
                  onPressed: _addStep,
                  icon: const Icon(Icons.add_circle),
                  color: scheme.primary,
                  tooltip: '添加步骤',
                ),
              ],
            ),
            if (_steps.isNotEmpty) ...[
              const SizedBox(height: 6),
              for (var i = 0; i < _steps.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: scheme.primaryContainer,
                            shape: BoxShape.circle),
                        child: Text('${i + 1}',
                            style: const TextStyle(fontSize: 11)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(_steps[i])),
                      GestureDetector(
                        onTap: () => setState(() => _steps.removeAt(i)),
                        child: Icon(Icons.close,
                            size: 16, color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
            ],
            const SizedBox(height: 16),

            // 贴士（可选）
            TextField(
              controller: _tipsCtrl,
              decoration: const InputDecoration(
                labelText: '小贴士（可选）',
                hintText: '例如：冷藏后更好吃',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            FilledButton.icon(
              onPressed: _canSave ? _save : null,
              icon: const Icon(Icons.check),
              label: const Text('加入菜谱池'),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text('添加后可被「换一道」换到，也能 ✏️ 记入日记',
                  style: TextStyle(
                      fontSize: 12, color: scheme.onSurfaceVariant)),
            ),
          ],
        ),
      ),
    );
  }
}
