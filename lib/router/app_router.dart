import 'package:flutter_all_in_one/presentation/authentication/login_screen.dart';
import 'package:flutter_all_in_one/presentation/home/features/firebase_remote_config_screen.dart';
import 'package:flutter_all_in_one/presentation/profile/language_screen.dart';
import 'package:flutter_all_in_one/presentation/qr_scanner/qr_scanner_screen.dart';
import 'package:go_router/go_router.dart';

import '../presentation/nav/nav_screen.dart';
import '../presentation/splash/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static final String splash = '/';
  static final String login = '/login';
  static final String nav = '/nav';
  static final String language = '/language';
  static final String qrScanner = '/qrScanner';

  /// HomeScreen's Features
  static final String firebaseRemoteConfig = '/firebaseRemoteConfig';

  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => LoginScreen(),
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

      /// HomeScreen's Features
      GoRoute(
        path: firebaseRemoteConfig,
        builder: (context, state) => FirebaseRemoteConfigScreen(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
