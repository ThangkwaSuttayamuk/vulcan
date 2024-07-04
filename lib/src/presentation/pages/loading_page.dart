import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingPage extends ConsumerStatefulWidget {
  const LoadingPage({super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends ConsumerState<LoadingPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late AnimationController _secondController;
  late Animation<Offset> _secondSlideAnimation;
  late AnimationController _thirdController;
  late Animation<Offset> _thirdSlideAnimation;
  late AnimationController _forthController;
  late Animation<Offset> _forthSlideAnimation;
  late AnimationController _fifthController;
  late Animation<Offset> _fifthSlideAnimation;
  List<Color> colorList = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      animationBehavior: AnimationBehavior.preserve,
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -1))
        .animate(CurvedAnimation(
            reverseCurve: Curves.linear,
            parent: _controller,
            curve: Curves.linear)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
              Future.delayed(const Duration(milliseconds: 200), () {
                setState(() {
                  _secondController.forward();
                });
              });
            }
          }));

    _secondController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      animationBehavior: AnimationBehavior.preserve,
    );

    _secondSlideAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -1)).animate(
            CurvedAnimation(
                reverseCurve: Curves.linear,
                parent: _secondController,
                curve: Curves.linear)
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  _secondController.reverse();
                  Future.delayed(const Duration(milliseconds: 200), () {
                    setState(() {});
                    _thirdController.forward();
                  });
                }
              }));

    _thirdController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      animationBehavior: AnimationBehavior.preserve,
    );

    _thirdSlideAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -1)).animate(
            CurvedAnimation(
                reverseCurve: Curves.linear,
                parent: _thirdController,
                curve: Curves.linear)
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  _thirdController.reverse();
                  Future.delayed(const Duration(milliseconds: 200), () {
                    setState(() {});
                    _forthController.forward();
                  });
                }
              }));

    _forthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      animationBehavior: AnimationBehavior.preserve,
    );

    _forthSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -1)).animate(
            CurvedAnimation(
                reverseCurve: Curves.linear,
                parent: _forthController,
                curve: Curves.linear)
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  _forthController.reverse();
                  Future.delayed(const Duration(milliseconds: 200), () {
                    setState(() {});
                    _fifthController.forward();
                  });
                }
              }));

    _fifthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      animationBehavior: AnimationBehavior.preserve,
    );

    _fifthSlideAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -1)).animate(
            CurvedAnimation(
                reverseCurve: Curves.linear,
                parent: _fifthController,
                curve: Curves.linear)
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  _fifthController.reverse();
                  Future.delayed(const Duration(milliseconds: 680), () {
                    setState(() {});
                    _controller.forward();
                  });
                }
              }));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    _forthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return SlideTransition(
                position: _slideAnimation,
                child: SizedBox(
                    height: 30,
                    child: Image(
                        image: AssetImage(
                            'assets/images/icon_burger_active.png'))),
              );
            },
          ),
          AnimatedBuilder(
            animation: _secondController,
            builder: (context, child) {
              return SlideTransition(
                position: _secondSlideAnimation,
                child: SizedBox(
                    height: 30,
                    child: Image(
                        image:
                            AssetImage('assets/images/icon_pizza_active.png'))),
              );
            },
          ),
          AnimatedBuilder(
            animation: _thirdController,
            builder: (context, child) {
              return SlideTransition(
                position: _thirdSlideAnimation,
                child: SizedBox(
                    height: 30,
                    child: Image(
                        image:
                            AssetImage('assets/images/icon_bread_active.png'))),
              );
            },
          ),
          AnimatedBuilder(
            animation: _forthController,
            builder: (context, child) {
              return SlideTransition(
                position: _forthSlideAnimation,
                child: SizedBox(
                    height: 30,
                    child: Image(
                        image:
                            AssetImage('assets/images/icon_salad_active.png'))),
              );
            },
          ),
          AnimatedBuilder(
            animation: _fifthController,
            builder: (context, child) {
              return SlideTransition(
                position: _fifthSlideAnimation,
                child: SizedBox(
                    height: 30,
                    child: Image(
                        image: AssetImage(
                            'assets/images/icon_fried_chicken_active.png'))),
              );
            },
          )
        ],
      )),
    );
  }
}
