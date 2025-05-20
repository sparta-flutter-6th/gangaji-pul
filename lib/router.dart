import 'package:flutter/material.dart';
import 'package:gangaji_pul/presentation/view/board_page/board_page.dart';
import 'package:gangaji_pul/presentation/view/bottom_nav_bar.dart';
import 'package:gangaji_pul/presentation/view/home_page/home_page.dart';
import 'package:gangaji_pul/presentation/view/my_page/my_page.dart';
import 'package:gangaji_pul/presentation/view/splash_page/splash.dart';
import 'package:gangaji_pul/presentation/view/writing_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
    ShellRoute(
      builder: (context, state, child) {
        return BottomNavigationShell(child: child);
      },
      routes: [
        GoRoute(path: '/home', pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(child: HomePage())),
        GoRoute(path: '/board', pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(child: BoardPage())),
        GoRoute(path: '/mypage', pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(child: MyPage())),
      ],
    ),
    GoRoute(path: '/write', builder: (context, state) => const WritingPage()),
  ],
);
