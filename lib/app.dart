/// 应用根组件：Material 3 主题 + 底部导航骨架
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/diary/diary_page.dart';
import 'features/home/home_page.dart';
import 'features/onboarding/onboarding_page.dart';
import 'features/plan/all_recipes_page.dart';
import 'features/plan/weekly_plan_page.dart';
import 'features/weight/weight_page.dart';

class LiteBiteApp extends StatelessWidget {
  const LiteBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 绿色系主题：健康、清新
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32));

    return MaterialApp.router(
      title: '轻食记',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        cardTheme: const CardThemeData(margin: EdgeInsets.zero),
      ),
      routerConfig: _router,
      locale: const Locale('zh', 'CN'),
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(path: '/onboarding', builder: (c, s) => const OnboardingPage()),
    ShellRoute(
      builder: (context, state, child) => _ScaffoldWithNav(child: child),
      routes: [
        GoRoute(path: '/', builder: (c, s) => const HomePage()),
        GoRoute(path: '/diary', builder: (c, s) => const DiaryPage()),
        GoRoute(path: '/plan', builder: (c, s) => const WeeklyPlanPage()),
        GoRoute(
            path: '/plan/all', builder: (c, s) => const AllRecipesPage()),
        GoRoute(path: '/weight', builder: (c, s) => const WeightPage()),
      ],
    ),
  ],
);

class _ScaffoldWithNav extends StatelessWidget {
  const _ScaffoldWithNav({required this.child});

  final Widget child;

  static const _tabs = [
    (icon: Icons.home_outlined, selected: Icons.home, label: '今日'),
    (icon: Icons.restaurant_outlined, selected: Icons.restaurant, label: '日记'),
    (icon: Icons.menu_book_outlined, selected: Icons.menu_book, label: '食谱'),
    (icon: Icons.monitor_weight_outlined, selected: Icons.monitor_weight, label: '体重'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = switch (location) {
      '/diary' => 1,
      '/plan' => 2,
      '/weight' => 3,
      _ => 0,
    };

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => context.go(switch (i) {
              1 => '/diary',
              2 => '/plan',
              3 => '/weight',
              _ => '/',
            }),
        destinations: [
          for (final t in _tabs)
            NavigationDestination(
              icon: Icon(t.icon),
              selectedIcon: Icon(t.selected),
              label: t.label,
            ),
        ],
      ),
    );
  }
}
