import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/float_button/float_button_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatButtonNotifier extends StateNotifier<FloatButtonState> {
  FloatButtonNotifier(super.state);

  void initPosition(double x, double y) {
    final double height = y - 160.h;
    final double width = x - 80.w;
    state = state.copyWith(dx: width, dy: height);
  }

  void updatePosition(double deltaX, double deltaY) {
    state = state.copyWith(dx: state.dx + deltaX, dy: state.dy + deltaY);
  }

  void limitMaxHeight(double maxHeight) {
    state = state.copyWith(dy: maxHeight);
  }

  void limitMaxWidth(double maxWidth) {
    state = state.copyWith(dx: maxWidth);
  }

  void limitMinHeight(double minHeight) {
    state = state.copyWith(dy: minHeight);
  }

  void limitMinWidth(double minWidth) {
    state = state.copyWith(dx: minWidth);
  }
}
