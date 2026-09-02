/// 营养计算单元测试（Mifflin-St Jeor 公式 + 减脂缺口）
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:litebite/domain/calc/nutrition_calc.dart';

void main() {
  group('BMR（Mifflin-St Jeor）', () {
    test('男性 25岁 175cm 75kg ≈ 1730 kcal', () {
      final p = UserProfile(
        gender: Gender.male,
        age: 25,
        heightCm: 175,
        weightKg: 75,
        activity: ActivityLevel.moderate,
        deficit: DeficitLevel.mild,
      );
      // 10*75 + 6.25*175 - 5*25 + 5 = 750+1093.75-125+5 = 1723.75
      expect(p.bmr, closeTo(1723.75, 0.01));
    });

    test('女性 30岁 160cm 55kg ≈ 1260 kcal', () {
      final p = UserProfile(
        gender: Gender.female,
        age: 30,
        heightCm: 160,
        weightKg: 55,
        activity: ActivityLevel.light,
        deficit: DeficitLevel.mild,
      );
      // 10*55 + 6.25*160 - 5*30 - 161 = 550+1000-150-161 = 1239
      expect(p.bmr, closeTo(1239, 0.01));
    });
  });

  group('TDEE 与减脂目标', () {
    test('中度活动系数 1.55：1723.75 * 1.55 ≈ 2671.8', () {
      final p = UserProfile(
        gender: Gender.male,
        age: 25,
        heightCm: 175,
        weightKg: 75,
        activity: ActivityLevel.moderate,
        deficit: DeficitLevel.mild,
      );
      expect(p.tdee, closeTo(2671.8, 1));
    });

    test('温和缺口 300kcal：目标 = TDEE - 300', () {
      final p = UserProfile(
        gender: Gender.male,
        age: 25,
        heightCm: 175,
        weightKg: 75,
        activity: ActivityLevel.moderate,
        deficit: DeficitLevel.mild,
      );
      expect(p.dailyKcalTarget, (p.tdee - 300).round());
    });

    test('激进缺口 750kcal，但不低于 BMR×1.05 安全线', () {
      final p = UserProfile(
        gender: Gender.male,
        age: 25,
        heightCm: 175,
        weightKg: 75,
        activity: ActivityLevel.moderate,
        deficit: DeficitLevel.aggressive,
      );
      expect(p.dailyKcalTarget, (p.tdee - 750).round());
      expect(p.dailyKcalTarget, greaterThanOrEqualTo((p.bmr * 1.05).round() - 1));
    });
  });

  group('宏量分配', () {
    test('蛋白质 25% / 脂 30% / 碳水 45% 且克数换算正确', () {
      final p = UserProfile(
        gender: Gender.male,
        age: 25,
        heightCm: 175,
        weightKg: 75,
        activity: ActivityLevel.moderate,
        deficit: DeficitLevel.mild,
      );
      final (protein, fat, carb) = p.macroTargets;
      expect(protein, closeTo(p.dailyKcalTarget * 0.25 / 4, 0.01));
      expect(fat, closeTo(p.dailyKcalTarget * 0.30 / 9, 0.01));
      expect(carb, closeTo(p.dailyKcalTarget * 0.45 / 4, 0.01));
    });
  });

  group('BMI（中国标准 WGOC）', () {
    test('75kg/1.75m = 24.5 → 正常上限附近', () {
      final p = UserProfile(
        gender: Gender.male,
        age: 25,
        heightCm: 175,
        weightKg: 75,
        activity: ActivityLevel.moderate,
        deficit: DeficitLevel.mild,
      );
      expect(p.bmi, closeTo(24.49, 0.01));
    });
  });
}
