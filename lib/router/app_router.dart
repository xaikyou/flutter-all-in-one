import 'package:flutter_all_in_one/presentation/profile/language_screen.dart';
import 'package:flutter_all_in_one/presentation/qr_scanner/qr_scanner_screen.dart';
import 'package:go_router/go_router.dart';

import '../presentation/nav/nav_screen.dart';
import '../presentation/splash/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static final String splash = '/';
  static final String nav = '/nav';
  static final String language = '/language';
  static final String qrScanner = '/qrScanner';

  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: nav,
        builder: (context, state) => NavScreen(),
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
