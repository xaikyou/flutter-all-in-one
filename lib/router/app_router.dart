import 'package:go_router/go_router.dart';

import '../presentation/nav/nav_screen.dart';
import '../presentation/splash/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static final String splash = '/';
  static final String nav = '/nav';

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
    ],
  );

  static GoRouter get router => _router;
}
