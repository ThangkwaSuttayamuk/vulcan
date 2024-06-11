import 'package:flutter_application_1/src/presentation/controller/text_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/text_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textProvider =
    StateNotifierProvider.autoDispose<TextController, TextState>(
        (ref) => TextController(TextState()));
