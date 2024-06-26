class Favorite
{
  int? favorite_id;
  int? user_id;
  int? id_product;
  String? name;
  double? rating;
  List<String>? tags;
  double? price;
  List<String>? sizes;
  List<String>? colors;
  String? description;
  String? image;

  Favorite({
    this.favorite_id,
    this.user_id,
    this.id_product,
    this.name,
    this.rating,
    this.tags,
    this.price,
    this.sizes,
    this.colors,
    this.description,
    this.image,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    favorite_id: int.parse(json['favorite_id']),
    user_id: int.parse(json['user_id']),
    id_product: int.parse(json['id_product']),
    name: json['product_name'],
    rating: double.parse(json['rating']),
    tags: json['tags'].toString().split(', '),
    price: double.parse(json['price']),
    sizes: json['sizes'].toString().split(', '),
    colors: json['colors'].toString().split(', '),
    description: json['description'],
    image: json['image'],
  );
}