/// 数据层：周食谱计划（assets/seed/weekly_plan.json）+ 用户自定义换菜
library;

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

/// 单道菜谱
class Recipe {
  const Recipe({
    required this.id,
    required this.name,
    required this.emoji,
    required this.kcal,
    required this.protein,
    required this.fat,
    required this.carb,
    required this.ingredients,
    required this.steps,
    required this.tips,
    required this.slots,
    this.imageUrl,
    this.isCustom = false,
  });

  final String id;
  final String name;
  final String emoji;
  final int kcal;
  final int protein;
  final int fat;
  final int carb;
  final List<({String n, String g})> ingredients;
  final List<String> steps;
  final String tips;
  /// 适合的餐次（0早 1午 2晚 3加餐）
  final List<int> slots;

  /// 在线图片（howtocook 扩充菜谱用；优先本地 asset，没有才联网）
  final String? imageUrl;

  /// 用户自定义菜谱（可删除）
  final bool isCustom;

  /// 配图 asset 路径（打包离线图）
  String get imageAsset => 'assets/images/recipes/$id.jpg';
  bool get hasMacro => protein > 0 || fat > 0 || carb > 0;

  Recipe copyWith({
    String? id,
    bool? isCustom,
    String? tips,
  }) =>
      Recipe(
        id: id ?? this.id,
        name: name,
        emoji: emoji,
        kcal: kcal,
        protein: protein,
        fat: fat,
        carb: carb,
        ingredients: ingredients,
        steps: steps,
        tips: tips ?? this.tips,
        slots: slots,
        imageUrl: imageUrl,
        isCustom: isCustom ?? this.isCustom,
      );

  factory Recipe.fromJson(String id, Map<String, dynamic> j) => Recipe(
        id: id,
        name: j['name'] as String,
        emoji: j['emoji'] as String,
        kcal: (j['kcal'] as num).toInt(),
        protein: (j['protein'] as num).toInt(),
        fat: (j['fat'] as num).toInt(),
        carb: (j['carb'] as num).toInt(),
        ingredients: [
          for (final i in (j['ingredients'] as List))
            (n: i['n'] as String, g: i['g'] as String),
        ],
        steps: [for (final s in (j['steps'] as List)) s as String],
        tips: j['tips'] as String,
        slots: [for (final s in (j['slots'] as List)) (s as num).toInt()],
      );
}

/// 一天的四餐计划（应用用户换菜后的最终结果）
class DayPlan {
  const DayPlan({required this.weekday, required this.meals});

  /// 1-7（周一~周日）
  final int weekday;
  /// slot(0早/1午/2晚/3加餐) → 菜谱列表
  final Map<int, List<Recipe>> meals;

  int get totalKcal =>
      meals.values.expand((l) => l).fold(0, (s, r) => s + r.kcal);
}

/// 周食谱仓库：预设 JSON + 用户换菜偏好 + 禁用（不吃）清单 + 自定义菜谱
class WeeklyPlanRepo {
  static const _path = 'assets/seed/weekly_plan.json';
  static const _extraPath = 'assets/seed/howtocook_extra.json';
  static const _prefKey = 'weekly_plan_overrides_v1';
  static const _bannedKey = 'recipe_banned_v1';
  static const _customKey = 'recipe_custom_v1';

  Map<String, Recipe>? _recipes;
  List<DayPlan>? _plans;
  Set<String> _banned = {};

  // ---------- 自定义菜谱 ----------

  /// 添加自定义菜谱（持久化并合并进菜池）；返回生成的 id
  Future<String> addCustomRecipe(Recipe r) async {
    await _ensureLoaded();
    final id = 'custom_${DateTime.now().millisecondsSinceEpoch}';
    final custom = r.copyWith(id: id, isCustom: true);
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_customKey) ?? [];
    list.add(jsonEncode({
      'id': id,
      'name': custom.name,
      'emoji': custom.emoji,
      'kcal': custom.kcal,
      'protein': custom.protein,
      'fat': custom.fat,
      'carb': custom.carb,
      'ingredients': [
        for (final i in custom.ingredients) {'n': i.n, 'g': i.g},
      ],
      'steps': custom.steps,
      'tips': custom.tips,
      'slots': custom.slots,
    }));
    await prefs.setStringList(_customKey, list);
    _recipes![id] = custom;
    return id;
  }

  /// 删除自定义菜谱（仅允许删自定义的）
  Future<void> removeCustomRecipe(String id) async {
    await _ensureLoaded();
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_customKey) ?? [];
    list.removeWhere((s) => (jsonDecode(s) as Map)['id'] == id);
    await prefs.setStringList(_customKey, list);
    _recipes?.remove(id);
    _banned.remove(id);
    // 换菜 override 里也清掉引用
    final raw = prefs.getString(_prefKey);
    if (raw != null) {
      final overrides = (jsonDecode(raw) as Map<String, dynamic>)
        ..removeWhere((_, v) => (v as List).contains(id));
      await prefs.setString(_prefKey, jsonEncode(overrides));
    }
  }

  // ---------- 禁用（不吃） ----------

  /// 是否已禁用
  bool isBanned(String id) => _banned.contains(id);

  /// 已禁用的菜谱 id 集合（只读）
  Set<String> get bannedIds => Set.unmodifiable(_banned);

  /// 禁用/恢复一道菜；返回操作后的状态（true=已禁用）
  Future<bool> toggleBanned(String id) async {
    if (_banned.contains(id)) {
      _banned.remove(id);
    } else {
      _banned.add(id);
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_bannedKey, _banned.toList());
    return _banned.contains(id);
  }

  /// 从禁用清单中挑一道替补（同餐次池里未被禁用的下一道）
  Recipe? replacementFor(int slot, String bannedId) {
    final pool = _recipes!.values
        .where((r) => r.slots.contains(slot) && !_banned.contains(r.id))
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    return pool.isEmpty ? null : pool.first;
  }

  Recipe _parseExtra(String id, Map<String, dynamic> j) => Recipe(
        id: id,
        name: j['name'] as String,
        emoji: j['emoji'] as String,
        kcal: (j['kcal'] as num).toInt(),
        protein: (j['protein'] as num).toInt(),
        fat: (j['fat'] as num).toInt(),
        carb: (j['carb'] as num).toInt(),
        ingredients: [
          for (final i in (j['ingredients'] as List))
            (n: i['n'] as String, g: i['g'] as String),
        ],
        steps: [for (final s in (j['steps'] as List)) s as String],
        tips: j['tips'] as String,
        slots: [for (final s in (j['slots'] as List)) (s as num).toInt()],
        imageUrl: j['imageUrl'] as String?,
      );

  Future<void> _ensureLoaded() async {
    if (_recipes != null) return;
    final raw = await rootBundle.loadString(_path);
    final data = jsonDecode(raw) as Map<String, dynamic>;
    _recipes = {
      for (final e in (data['recipes'] as Map<String, dynamic>).entries)
        e.key: Recipe.fromJson(e.key, e.value as Map<String, dynamic>),
    };
    // 扩充池：howtocook 低卡菜谱（换菜用，不进预设周计划）
    try {
      final extraRaw = await rootBundle.loadString(_extraPath);
      final extraList = jsonDecode(extraRaw) as List<dynamic>;
      for (final item in extraList) {
        final j = item as Map<String, dynamic>;
        final id = j['id'] as String;
        _recipes![id] = _parseExtra(id, j);
      }
    } catch (_) {
      // 扩充文件缺失不影响主流程
    }
    // 恢复禁用清单 + 自定义菜谱
    final prefs = await SharedPreferences.getInstance();
    _banned = (prefs.getStringList(_bannedKey) ?? const []).toSet();
    for (final s in (prefs.getStringList(_customKey) ?? const [])) {
      try {
        final j = jsonDecode(s) as Map<String, dynamic>;
        final id = j['id'] as String;
        _recipes![id] = _parseExtra(id, j);
      } catch (_) {/* 单条损坏跳过 */}
    }
    _plans = [
      for (final p in (data['plans'] as List))
        DayPlan(
          weekday: (p['weekday'] as num).toInt(),
          meals: {
            for (final e in (p['meals'] as Map<String, dynamic>).entries)
              int.parse(e.key): [
                for (final id in (e.value as List))
                  _recipes![id as String]!,
              ],
          },
        ),
    ];
  }

  // ---------- 换菜偏好 ----------

  /// 读取应用了用户换菜+禁用后的周计划
  Future<List<DayPlan>> loadWeek() async {
    await _ensureLoaded();
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefKey);
    final overrides = raw == null || raw.isEmpty
        ? null
        : (jsonDecode(raw) as Map<String, dynamic>).map(
            (k, v) =>
                MapEntry(k, (v as List).map((e) => e as String).toList()));

    return [
      for (final day in _plans!)
        DayPlan(
          weekday: day.weekday,
          meals: {
            for (final e in day.meals.entries)
              e.key: _buildSlot(day.weekday, e.key, e.value, overrides),
          },
        ),
    ];
  }

  /// 组装某天某餐的最终菜谱：换菜 override > 禁用过滤 > 自动补位
  List<Recipe> _buildSlot(int weekday, int slot, List<Recipe> preset,
      Map<String, List<String>>? overrides) {
    var list = _applyOverrides(
        weekday, slot, preset, overrides ?? const {});
    // 过滤禁用菜
    final visible = list.where((r) => !_banned.contains(r.id)).toList();
    if (visible.isNotEmpty) return visible;
    // 全被禁用：从同餐次池自动补一道没禁用的
    final sub = replacementFor(slot, '');
    return sub == null ? preset : [sub];
  }

  /// 全部菜谱（预设 + 扩充池），须先调 loadWeek()
  List<Recipe> get allRecipes {
    final list = _recipes?.values.toList() ?? const <Recipe>[];
    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  }

  List<Recipe> _applyOverrides(int weekday, int slot, List<Recipe> preset,
      Map<String, List<String>> overrides) {
    final key = '$weekday:$slot';
    final ids = overrides[key];
    if (ids == null) return preset;
    final list = <Recipe>[];
    for (final id in ids) {
      final r = _recipes![id];
      if (r != null) list.add(r);
    }
    return list.isEmpty ? preset : list;
  }

  /// 换一道菜：把某天某餐的菜换成池中下一道（跳过禁用的）
  Future<Recipe> swapNext(int weekday, int slot, String currentId) async {
    await _ensureLoaded();
    final pool = _recipes!.values
        .where((r) => r.slots.contains(slot) && !_banned.contains(r.id))
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    if (pool.isEmpty) throw StateError('该餐次没有可换的菜');
    final idx = pool.indexWhere((r) => r.id == currentId);
    final next = pool[(idx + 1) % pool.length];

    final prefs = await SharedPreferences.getInstance();
    final overrides = await _readOverrides(prefs);
    overrides['$weekday:$slot'] = [next.id];
    await prefs.setString(_prefKey, jsonEncode(overrides));
    return next;
  }

  /// 恢复某天某餐为预设
  Future<void> resetSlot(int weekday, int slot) async {
    final prefs = await SharedPreferences.getInstance();
    final overrides = await _readOverrides(prefs);
    overrides.remove('$weekday:$slot');
    await prefs.setString(_prefKey, jsonEncode(overrides));
  }

  Future<Map<String, List<String>>> _readOverrides(
      SharedPreferences prefs) async {
    final raw = prefs.getString(_prefKey);
    if (raw == null || raw.isEmpty) return {};
    return (jsonDecode(raw) as Map<String, dynamic>)
        .map((k, v) => MapEntry(k, (v as List).map((e) => e as String).toList()));
  }
}
