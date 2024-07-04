import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchAnimated extends StatefulWidget {
  const SearchAnimated({super.key});

  @override
  State<SearchAnimated> createState() => _SearchAnimatedState();
}

class _SearchAnimatedState extends State<SearchAnimated>
    with SingleTickerProviderStateMixin {
  final List<String> texts = [
    'Hawaiian Pizza 🍕',
    'Buy 1 get 1 free CheeseBurger 🍔',
    'Healthy Fresh Salad 🥗'
  ];

  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      animationBehavior: AnimationBehavior.preserve,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: const Offset(0, 0))
            .animate(CurvedAnimation(
                reverseCurve: Curves.easeOutExpo,
                parent: _controller,
                curve: Curves.easeOutExpo));
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Future.delayed(const Duration(seconds: 3), () {
                setState(() {
                  _currentIndex = (_currentIndex + 1) % texts.length;
                });
                _controller.forward(from: 0.0);
              });
            }
          });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      automaticallyImplyLeading: false,
      floating: true,
      pinned: true,
      elevation: 0,
      stretch: false,
      flexibleSpace: SizedBox(
          height: 45.h,
          child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/search'),
              child: AbsorbPointer(
                  child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade700)),
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 15.0, height: 100.0),
                    Icon(Icons.search),
                    const SizedBox(width: 10.0, height: 100.0),
                    DefaultTextStyle(
                      style: TextStyle(
                          fontSize: 14.0, color: Theme.of(context).textTheme.titleMedium?.color),
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return SlideTransition(
                            position: _slideAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: Text(
                                texts[_currentIndex],
                                key: ValueKey<int>(_currentIndex),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )))),
    );
  }
}
