import '../../domain/entities/food_entity.dart';

class FoodModel extends FoodEntity{
  FoodModel({
    required super.id,
    required super.name,
    required super.description,
    required super.ingredient,
    required super.price,
    required super.image,
  });


  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      ingredient: List<String>.from(json['ingredient']),
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}
