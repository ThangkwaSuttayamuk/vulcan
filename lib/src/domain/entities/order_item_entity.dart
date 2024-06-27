class OrderItemEntity {
  final int orderId;
  final int foodId;
  final String name;
  final String image;
  final double price;
  final int quantity;

  OrderItemEntity({
    required this.orderId,
    required this.foodId,
    required this.quantity,
    required this.name,
    required this.image,
    required this.price,
  });

  factory OrderItemEntity.fromMap(Map<String, dynamic> map) {
    return OrderItemEntity(
        orderId: map['orderItemId'],
        foodId: map['food_id'],
        quantity: map['quantity'],
        name: map['name'],
        image: map['image'],
        price: map['price']);
  }
}
