class Resto {
  final int id;
  final String name;
  final String address;
  final String imgurl;
  final String typeResto;
  Resto({
    required this.id,
    required this.name,
    required this.address,
    required this.imgurl,
    required this.typeResto,

  });

  factory Resto.fromJson(Map<String, dynamic> json) {
    return Resto(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      imgurl: json['imgurl'],
      typeResto: json['typeResto'],
    );
  }
}
