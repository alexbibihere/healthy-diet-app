# 轻食记 LiteBite 🥗

> 离线优先的减脂饮食助手 —— 每周食谱计划 + 菜谱做法 + 轻量饮食/体重记录

一个纯本地运行的 Flutter 减脂餐 App：内置营养师设计的周食谱（可换菜、可屏蔽不爱吃的菜），134 道低卡中餐带图做法，一键记入饮食日记，体重趋势曲线。**无账号、无网络依赖、无数据上传。**

## ✨ 功能

- **每周食谱** — 周一~周日 × 早/午/晚/加餐的营养师预设，今天高亮，日总热量预估
- **当天食谱** — 左上角一键切换，只看今天吃什么
- **菜谱详情** — 大图 + 热量/宏量 + 食材克数清单 + 分步做法 + 小贴士
- **换一道** — 按餐次自动从菜池轮换，不喜欢一键换掉
- **不吃清单** — 列表左滑禁用不爱吃的菜，全食谱/换菜池自动避开，可恢复
- **一键记入日记** — 菜谱列表直接 ✏️ 记入今日日记，按时段智能选餐次
- **饮食日记** — 按日期查看四餐记录与热量
- **体重趋势** — fl_chart 折线图，同日覆盖写入
- **首次引导** — Mifflin-St Jeor 公式算 BMR/TDEE，三档减脂缺口，实时目标预览
- **全部食谱** — 134 道菜搜索 + 餐次筛选浏览

## 🛠 技术栈

| 层 | 选型 |
|---|---|
| 框架 | Flutter 3.47 (Dart 3.13)，Material 3 |
| 状态管理 | flutter_riverpod（手写 Provider） |
| 数据库 | drift (SQLite) + drift_flutter |
| 路由 | go_router + ShellRoute 底部导航 |
| 图表 | fl_chart |
| 偏好存储 | shared_preferences（换菜/禁用清单） |

## 📂 结构

```
lib/
├── data/
│   ├── db/            # drift 表定义 + DAO（4 表：profile/foods/entries/weight_logs）
│   ├── seed/          # 内置食物库 + 周食谱 JSON 加载
│   └── plan/          # 周食谱仓库（预设 + 换菜/禁用持久化）
├── domain/calc/       # BMR/TDEE/宏量 营养计算（含 7 个单元测试）
├── features/
│   ├── home/          # 今日仪表盘（热量环 + 三大宏量）
│   ├── plan/          # 周食谱 / 全部食谱 / 菜谱详情 / 记入日记
│   ├── food/          # 食物搜索选择器
│   ├── diary/         # 饮食日记
│   ├── weight/        # 体重趋势
│   └── onboarding/    # 首次建档引导
└── main.dart / app.dart
```

## 🍱 食谱数据

- 20 道精修减脂餐（完整宏量 + 克数，营养师口径设计）
- 114 道低卡菜谱来自 [HowToCook](https://github.com/Anduin2017/HowToCook)（Unlicense 协议），≤500 kcal 筛选
- 20 张精修配图（Wikimedia Commons 免费商用）+ 53 张 HowToCook 图
- 40 种常见中餐食材营养数据（每 100g）

## 🚀 运行

```bash
flutter pub get
flutter run                 # 真机/模拟器
flutter test                # 单元测试（营养计算）
flutter build apk --release --split-per-abi
```

## 📄 License

代码 MIT。食谱数据部分来自 HowToCook（Unlicense）与 Wikimedia Commons（各自许可），详见数据文件内标注。

---
Made with 💚 by alexbibihere · 纯离线，数据永不出设备
