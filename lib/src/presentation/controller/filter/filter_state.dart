class FilterState {
  final String filterName;

  FilterState({required this.filterName});

  FilterState copyWith({String? filterName}) {
    return FilterState(filterName: filterName ?? this.filterName);
  }
}
