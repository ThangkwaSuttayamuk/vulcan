class Food {
  String id;
  String name;
  String description;
  List<String> ingredient;
  double price;
  String image;

  Food(
      {required this.id,
      required this.name,
      required this.description,
      required this.ingredient,
      required this.price,
      required this.image});
}
