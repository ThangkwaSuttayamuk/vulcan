class FoodEntity {
  String id;
  String name;
  String description;
  List<String> ingredient;
  double price;
  String image;

  FoodEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.ingredient,
      required this.price,
      required this.image});
}
