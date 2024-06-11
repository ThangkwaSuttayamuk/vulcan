

class Food {
  final int id;
  final String name;
  final String description;
  final List<String> ingredients;
  final double price;
  final String image;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.price,
    required this.image,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      ingredients: json['ingredients'] != null
          ? List<String>.from(json['ingredients'])
          : [],
      price: (json['price'] ?? 0.0).toDouble(),
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'ingredients': ingredients.join(', '),
      'price': price,
      'image': image,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      ingredients: (map['ingredient'] != null && map['ingredient'] != '')
          ? map['ingredient']
              .split(', ')
              .map((ingredient) => ingredient.toString())
              .toList()
          : [],
      price: (map['price'] ?? 0.0).toDouble(),
      image: map['image'] ?? '',
    );
  }
}
