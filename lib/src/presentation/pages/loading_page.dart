import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/user/user_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/user/user_state.dart';
import 'package:flutter_application_1/src/presentation/pages/home_page.dart';
import 'package:flutter_application_1/src/presentation/pages/login_page.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).checkLogin();
    });
    _controller = controller();
    _secondController = controller();
    _thirdController = controller();
    _forthController = controller();
    _fifthController = controller();

    _slideAnimation = tween(_controller, _secondController);
    _secondSlideAnimation = tween(_secondController, _thirdController);
    _thirdSlideAnimation = tween(_thirdController, _forthController);
    _forthSlideAnimation = tween(_forthController, _fifthController);
    _fifthSlideAnimation = tween(_fifthController, _controller);

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
    final user = ref.watch(userProvider);
    if (user.loginStatus == UserStatus.login) {
      return HomePage();
    }
    if (user.loginStatus == UserStatus.notLogin) {
      return LoginPage();
    }
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              animatedBuilder(_controller, _slideAnimation, 'burger'),
              animatedBuilder(
                  _secondController, _secondSlideAnimation, 'pizza'),
              animatedBuilder(_thirdController, _thirdSlideAnimation, 'bread'),
              animatedBuilder(_forthController, _forthSlideAnimation, 'salad'),
              animatedBuilder(
                  _fifthController, _fifthSlideAnimation, 'fried_chicken'),
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              'HappyMeal',
              style: TextStyle(
                  color: Theme.of(context).textTheme.titleLarge?.color,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  AnimationController controller() {
    return AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      animationBehavior: AnimationBehavior.preserve,
    );
  }

  Animation<Offset> tween(AnimationController firstController,
      AnimationController secondController) {
    return Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -1))
        .animate(CurvedAnimation(
            reverseCurve: Curves.linear,
            parent: firstController,
            curve: Curves.linear)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              firstController.reverse();
              Future.delayed(const Duration(milliseconds: 200), () {
                setState(() {
                  secondController.forward();
                });
              });
            }
          }));
  }

  AnimatedBuilder animatedBuilder(AnimationController controller,
      Animation<Offset> sliderAnimation, String image) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return SlideTransition(
          position: sliderAnimation,
          child: SizedBox(
              height: 30,
              child: Image(
                  image: AssetImage('assets/images/icon_${image}_active.png'))),
        );
      },
    );
  }
}
