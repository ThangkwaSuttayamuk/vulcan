import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/float_button/float_button_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DragableButton extends ConsumerStatefulWidget {
  const DragableButton({Key? key}) : super(key: key);

  @override
  _DragableButtonState createState() => _DragableButtonState();
}

class _DragableButtonState extends ConsumerState<DragableButton>
    with SingleTickerProviderStateMixin {
  double x = 0;
  double y = 0;
  String percentage = '30%';
  Timer? _timer;
  List<String> percentages = ['30%', '40%'];
  int _currentIndex = 0;

  double minHeight = 80.h;
  double minWidth = 10.h;

  bool isFirst = true;
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   x = MediaQuery.of(context).size.width;
    //   y = MediaQuery.of(context).size.height;
    //   ref.read(floatButtonProvider.notifier).initPosition(x, y);
    // });
    // x = MediaQuery.of(context).size.width;
    // y = MediaQuery.of(context).size.height;
    // ref.read(floatButtonProvider.notifier).initPosition(x, y);
    _startTimer();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    x = MediaQuery.of(context).size.width;
    y = MediaQuery.of(context).size.height;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(floatButtonProvider.notifier).initPosition(x, y);
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % percentages.length;
        percentage = percentages[_currentIndex];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height - 160.h;
    double maxWidth = MediaQuery.of(context).size.width - 80.w;

    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final dx = ref.watch(floatButtonProvider.select((value) => value.dx));
      final dy = ref.watch(floatButtonProvider.select((value) => value.dy));
      final showBanner =
          ref.watch(foodListProvider.select((value) => value.showBanner));
      return Visibility(
        visible: showBanner,
        child: AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.elasticOut,
            left: dx,
            top: dy,
            child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    ref
                        .read(floatButtonProvider.notifier)
                        .updatePosition(details.delta.dx, details.delta.dy);

                    if (dy > maxHeight) {
                      ref
                          .read(floatButtonProvider.notifier)
                          .limitMaxHeight(maxHeight);
                    } else if (dy < minHeight) {
                      ref
                          .read(floatButtonProvider.notifier)
                          .limitMinHeight(minHeight);
                    }

                    if (dx < minWidth) {
                      ref
                          .read(floatButtonProvider.notifier)
                          .limitMinWidth(minWidth);
                    } else if (dx > maxWidth) {
                      ref
                          .read(floatButtonProvider.notifier)
                          .limitMaxWidth(maxWidth);
                    }
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    if (dx >= (MediaQuery.of(context).size.width / 2) - 32.w) {
                      ref
                          .read(floatButtonProvider.notifier)
                          .limitMaxWidth(maxWidth);
                    } else if (dx <
                        (MediaQuery.of(context).size.width / 2) - 32.w) {
                      ref
                          .read(floatButtonProvider.notifier)
                          .limitMinWidth(minWidth);
                    }
                  });
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 6.0.w),
                      child: CircleAvatar(
                        radius: 32.w,
                        backgroundColor: Colors.blue,
                        child: AnimatedSwitcher(
                          duration: const Duration(seconds: 0),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return child;
                          },
                          child: Text(
                            percentage,
                            key: ValueKey<String>(percentage),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          _timer?.cancel();
                          ref.read(foodListProvider.notifier).closeBanner();
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 10.w,
                              backgroundColor: Colors.black,
                            ),
                            Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))),
      );
    });
  }
}
