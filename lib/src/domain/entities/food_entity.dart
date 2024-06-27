class FoodEntity {
  final int id;
  final String name;
  final String description;
  final String ingredients;
  final double price;
  final String image;

  FoodEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.price,
    required this.image,
  });

  factory FoodEntity.fromJson(Map<String, dynamic> json) {
        return FoodEntity(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      ingredients: json['ingredients'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'ingredients': ingredients,
      'price': price,
      'image': image,
    };
  }

  factory FoodEntity.fromMap(Map<String, dynamic> map) {
    return FoodEntity(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      ingredients: map['ingredients'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      image: map['image'] ?? '',
    );
  }
}
