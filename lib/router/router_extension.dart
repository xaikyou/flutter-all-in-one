import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum SlideDirection { fromLeft, fromRight, fromTop, fromBottom }

extension RouterExtension on Widget {
  fadeSlideTransition({
    SlideDirection? direction,
    Duration? duration,
  }) =>
      CustomTransitionPage(
        child: this,
        transitionDuration: duration ?? const Duration(milliseconds: 400),
        reverseTransitionDuration:
            duration ?? const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          late Offset beginOffset;
          switch (direction) {
            case SlideDirection.fromLeft:
              beginOffset = const Offset(-1, 0);
            case SlideDirection.fromRight:
              beginOffset = const Offset(1, 0);
            case SlideDirection.fromTop:
              beginOffset = const Offset(0, -1);
            case SlideDirection.fromBottom:
              beginOffset = const Offset(0, 1);
            default:
              beginOffset = const Offset(1, 0);
          }

          Tween<Offset> slideTween =
              Tween(begin: beginOffset, end: Offset.zero);

          Animation<double> fadeAnimation =
              Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: animation,
              curve: const Interval(0.3, 1, curve: Curves.easeIn),
            ),
          );

          return SlideTransition(
            position: slideTween.animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: FadeTransition(
              opacity: fadeAnimation,
              child: child,
            ),
          );
        },
      );

  slideTransition({
    SlideDirection? direction,
    Duration? duration,
  }) =>
      CustomTransitionPage(
        child: this,
        transitionDuration: duration ?? const Duration(milliseconds: 250),
        reverseTransitionDuration:
            duration ?? const Duration(milliseconds: 250),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          late Offset beginOffset;
          switch (direction) {
            case SlideDirection.fromLeft:
              beginOffset = const Offset(-1, 0);
            case SlideDirection.fromRight:
              beginOffset = const Offset(1, 0);
            case SlideDirection.fromTop:
              beginOffset = const Offset(0, -1);
            case SlideDirection.fromBottom:
              beginOffset = const Offset(0, 1);
            default:
              beginOffset = const Offset(1, 0);
          }
          return SlideTransition(
            position: Tween(begin: beginOffset, end: Offset.zero)
                .animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
      );

  fadeTransition({Duration? duration}) => CustomTransitionPage(
        child: this,
        transitionDuration: duration ?? const Duration(microseconds: 250),
        reverseTransitionDuration:
            duration ?? const Duration(microseconds: 250),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
}

extension GoRouterExtension on GoRouter {
  String location() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}
