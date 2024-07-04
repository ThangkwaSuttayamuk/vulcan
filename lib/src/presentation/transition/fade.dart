import 'package:flutter/widgets.dart';

class Fade extends PageRouteBuilder {
  Widget child;
  Duration duration;

  Fade({required this.child, this.duration = const Duration(seconds: 2)})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return child;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(animation),
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 500));
}
