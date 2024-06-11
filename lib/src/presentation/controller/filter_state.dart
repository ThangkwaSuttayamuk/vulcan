import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterState {
  final String filterName;

  FilterState({required this.filterName});

  FilterState copyWith({String? filterName}) {
    return FilterState(filterName: filterName ?? this.filterName);
  }
}

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

final filterProvider =
    StateNotifierProvider.autoDispose<FilterNotifier, FilterState>((ref) {
  return FilterNotifier(FilterState(filterName: ''));
});
