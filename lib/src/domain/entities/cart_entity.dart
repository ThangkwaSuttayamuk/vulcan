class CartEntity {
  final int id;
  final int foodId;
  final String name;
  final String description;
  final String image;
  final double price;
  final int quantity;

  CartEntity({
    required this.id,
    required this.foodId,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory CartEntity.fromMap(Map<String, dynamic> map) {
    return CartEntity(
        id: map['cartId'] ?? 0,
        foodId: map['foodId'] ?? 0,
        name: map['name'],
        description: map['description'],
        image: map['image'],
        price: map['price'],
        quantity: map['quantity']);
  }
}
