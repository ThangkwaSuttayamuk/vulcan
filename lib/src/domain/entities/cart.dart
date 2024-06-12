class Cart {
  final int id;
  final int quantity;

  Cart({
    required this.id,
    required this.quantity,
  });

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(id: map['id'] ?? 0, quantity: map['quantity']);
  }
  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'quantity': quantity,
  //   };
  // }
}
