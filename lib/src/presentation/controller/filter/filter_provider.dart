
import 'package:flutter_application_1/src/presentation/controller/filter/filter_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/filter/filter_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterProvider =
    StateNotifierProvider.autoDispose<FilterNotifier, FilterState>((ref) {
  return FilterNotifier(FilterState(filterName: ''));
});