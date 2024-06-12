
import 'package:flutter_application_1/src/presentation/controller/filter/filter_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterNotifier extends StateNotifier<FilterState> {
  FilterNotifier(super.state);

  void setFilter(String filterName) {
    if (state.filterName != filterName) {
      // print(state.filterName);
      state = state.copyWith(filterName: filterName);
    } else {
      state = state.copyWith(filterName: '');
    }
  }
}