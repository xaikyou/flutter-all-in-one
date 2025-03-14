import 'package:flutter_all_in_one/presentation/authentication/login_screen.dart';
import 'package:flutter_all_in_one/presentation/favorite/favorite_screen.dart';
import 'package:flutter_all_in_one/presentation/history/history_screen.dart';
import 'package:flutter_all_in_one/presentation/home/home_screen.dart';
import 'package:flutter_all_in_one/presentation/profile/language_screen.dart';
import 'package:flutter_all_in_one/presentation/profile/profile_screen.dart';
import 'package:flutter_all_in_one/presentation/qr_scanner/qr_scanner_screen.dart';
import 'package:go_router/go_router.dart';

import '../presentation/nav/nav_screen.dart';
import '../presentation/splash/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static final String splash = '/';
  static final String login = '/login';
  static final String language = '/language';
  static final String qrScanner = '/qrScanner';

  static final GoRouter _router = GoRouter(
    initialLocation: splash,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => NavScreen(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/history',
                builder: (context, state) => const HistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorite',
                builder: (context, state) => const FavoriteScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: splash,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: language,
        builder: (context, state) => LanguageScreen(),
      ),
      GoRoute(
        path: qrScanner,
        builder: (context, state) => QrScannerScreen(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
