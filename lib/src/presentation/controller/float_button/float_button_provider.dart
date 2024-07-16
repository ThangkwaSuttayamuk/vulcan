import 'package:flutter_application_1/src/presentation/controller/float_button/float_button_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/float_button/float_button_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final floatButtonProvider =
StateNotifierProvider.autoDispose<FloatButtonNotifier, FloatButtonState>((ref) {
  return FloatButtonNotifier(FloatButtonState(dx: 0,dy:0));
});