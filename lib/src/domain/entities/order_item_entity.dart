class OrderItemEntity {
  final int? id;
  final int orderId;
  final int foodId;
  final int quantity;

  OrderItemEntity(
      {this.id,
      required this.orderId,
      required this.foodId,
      required this.quantity});

  factory OrderItemEntity.fromMap(Map<String, dynamic> map) {
    return OrderItemEntity(
      id: map['id'],
      orderId: map['order_id'],
      foodId: map['food_id'],
      quantity: map['quantity'],
    );
  }
}
