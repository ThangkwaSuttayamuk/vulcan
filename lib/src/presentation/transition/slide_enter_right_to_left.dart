import 'package:flutter/material.dart';

class SlideEnterRightToLeft extends PageRouteBuilder {
  Widget child;
  Duration duration;

  SlideEnterRightToLeft(
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
                  begin: Offset(1.0, 0.0),
                  end: Offset(0.0, 0.0),
                ).animate(animation),
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 100));
}
