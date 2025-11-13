class FoodItem {
  final String title;
  final String time;
  final String price;
  final String imagePath;
  final List<String> categories;
  int quantity;

  FoodItem({
    required this.title,
    required this.time,
    required this.price,
    required this.imagePath,
    required this.categories,
    this.quantity = 1,
  });
}