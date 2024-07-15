import 'package:flutter/material.dart';

/// A page transitions builder that doesn't apply any animation.
///
/// We will use it on the web as normally navigating through pages on the web
/// doesn't apply any animation.
class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    // only return the child without warping it with animations
    return child!;
  }
}
