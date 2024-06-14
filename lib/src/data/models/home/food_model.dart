
import '../../../domain/entities/food_entity.dart';

class FoodModel extends FoodEntity{
  FoodModel({
    required super.id,
    required super.name,
    required super.description,
    // required super.ingredients,
    required super.price,
    required super.image,
  });


  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      // ingredients: List<String>.from(json['ingredients']),
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      // 'ingredients': ingredients.join(', '),
      'price': price,
      'image': image,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      // ingredients: (map['ingredient'] != null && map['ingredients'] != '')
      //     ? map['ingredient']
      //         .split(', ')
      //         .map((ingredient) => ingredient.toString())
      //         .toList()
      //     : [],
      price: (map['price'] ?? 0.0).toDouble(),
      image: map['image'] ?? '',
    );
  }
}