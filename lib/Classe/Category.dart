//
// class Category {
//   final int id;
//   final String name;
//   final String imgurl;
//
//   Category({
//     required this.id,
//     required this.name,
//     required this.imgurl,
//
//
//
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['id'],
//       name: json['name'],
//       imgurl: json['imgurl'],
//     );
//   }
// }
class Category {
  final int id;
  final String name;
  final String imgurl;
  final int restoId; // Add the restoId property

  Category({
    required this.id,
    required this.name,
    required this.imgurl,
    required this.restoId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      imgurl: json['imgurl'] as String,
      restoId: json['restoId'] as int, // Initialize restoId from JSON
    );
  }
}
