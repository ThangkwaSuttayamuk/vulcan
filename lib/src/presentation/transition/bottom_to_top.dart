import 'package:flutter/material.dart';

class BottomToTop extends PageRouteBuilder {
  Widget child;
  Duration duration;

  BottomToTop(
      {required this.child, this.duration = const Duration(seconds: 2)})
      : super(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return child;
      },
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: const Offset(0.0, 0.0),
          ).animate(animation),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 100));
}
