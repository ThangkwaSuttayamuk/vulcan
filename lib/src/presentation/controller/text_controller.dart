import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/text_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextController extends StateNotifier<TextState> {
  TextController(super.state);

  final TextEditingController inputController = TextEditingController();

  void initData(){
    state = state.copyWith(strData: 'Hello');
  }
}
