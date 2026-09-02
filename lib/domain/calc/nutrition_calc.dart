/// 领域层：BMR / TDEE / 营养目标计算（纯 Dart，无依赖，可单测）
library;

/// 性别
enum Gender { male, female }

/// 活动水平（对应活动系数）
enum ActivityLevel {
  sedentary(1.2, '久坐不动'),
  light(1.375, '轻度活动（每周1-3次）'),
  moderate(1.55, '中度活动（每周3-5次）'),
  active(1.725, '高强度活动（每周6-7次）');

  const ActivityLevel(this.factor, this.label);
  final double factor;
  final String label;
}

/// 减脂速度（每日热量缺口）
enum DeficitLevel {
  mild(300, '温和减脂 ~0.25kg/周'),
  standard(500, '标准减脂 ~0.5kg/周'),
  aggressive(750, '激进减脂 ~0.75kg/周');

  const DeficitLevel(this.kcalDeficit, this.label);
  final int kcalDeficit;
  final String label;
}

/// 宏量营养素分配比例
class MacroRatio {
  const MacroRatio({
    this.protein = 0.25,
    this.fat = 0.30,
    this.carb = 0.45,
  });

  final double protein; // 蛋白质供能占比
  final double fat; // 脂肪供能占比
  final double carb; // 碳水供能占比

  /// 校验比例和为 1（±0.001）
  bool get isValid => (protein + fat + carb - 1).abs() < 0.001;

  /// 蛋白/脂肪/碳水每克供能: 4 / 9 / 4 kcal
  (double proteinG, double fatG, double carbG) toGrams(int kcal) => (
        kcal * protein / 4,
        kcal * fat / 9,
        kcal * carb / 4,
      );
}

/// 用户档案（计算输入）
class UserProfile {
  const UserProfile({
    required this.gender,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.activity,
    required this.deficit,
    this.ratio = const MacroRatio(),
  });

  final Gender gender;
  final int age;
  final double heightCm;
  final double weightKg;
  final ActivityLevel activity;
  final DeficitLevel deficit;
  final MacroRatio ratio;

  /// Mifflin-St Jeor 公式计算 BMR（基础代谢）
  double get bmr {
    final base = 10 * weightKg + 6.25 * heightCm - 5 * age;
    return gender == Gender.male ? base + 5 : base - 161;
  }

  double get tdee => bmr * activity.factor;

  /// 每日目标热量（减脂 = TDEE - 缺口；不低于基础代谢的安全下限 BMR×1.05）
  int get dailyKcalTarget {
    final raw = tdee - deficit.kcalDeficit;
    final floor = bmr * 1.05;
    return raw < floor ? floor.round() : raw.round();
  }

  /// 三大宏量目标（克）
  (double proteinG, double fatG, double carbG) get macroTargets =>
      ratio.toGrams(dailyKcalTarget);

  /// BMI（WHO 标准）
  double get bmi => weightKg / ((heightCm / 100) * (heightCm / 100));

  /// BMI 分级（中国 WGOC 标准）
  String get bmiLabel {
    final v = bmi;
    if (v < 18.5) return '偏瘦';
    if (v < 24) return '正常';
    if (v < 28) return '超重';
    return '肥胖';
  }

  // weightKm 是笔误防护：确保用 weightKg
  double get weightKm => weightKg;
}
