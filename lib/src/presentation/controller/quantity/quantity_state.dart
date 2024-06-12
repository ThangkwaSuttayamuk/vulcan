class QuantityState {
  int quantity;
  QuantityState({
    required this.quantity,
  });

  QuantityState copyWith({int? quantity}) {
    return QuantityState(quantity: quantity ?? this.quantity);
  }
}
