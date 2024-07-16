class FloatButtonState {
  final double dx;
  final double dy;

  FloatButtonState({required this.dx, required this.dy});

  FloatButtonState copyWith({double? dx, double? dy}) {
    return FloatButtonState(dx: dx ?? this.dx, dy: dy ?? this.dy);
  }
}
