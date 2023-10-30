class Food {
  final int id;
  final String name;
  final String description;
  final String imgUrl;
  final double price;
  final int totalRating;
  final double avgRating;

  final int restoId;
  final int categoryId;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.price,
    required this.totalRating,
    required this.avgRating,

    required this.restoId,
    required this.categoryId,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imgUrl: json['imgurl'],
      price: json['price'].toDouble(),
      totalRating: json['totalRating'],
      avgRating: json['avgRating'].toDouble(),
      restoId: json['restoId'],
      categoryId: json['categoryId'],
    );
  }
}
