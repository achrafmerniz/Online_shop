class Clothes
{
  int? id_product;
  String? name;
  double? rating;
  List<String>? tags;
  double? price;
  List<String>? sizes;
  List<String>? colors;
  String? description;
  String? image;
  String? category;

  Clothes({
    this.id_product,
    this.name,
    this.rating,
    this.tags,
    this.price,
    this.sizes,
    this.colors,
    this.description,
    this.image,
    this.category,
  });

  factory Clothes.fromJson(Map<String, dynamic> json) => Clothes(
    id_product: int.parse(json["id_product"]),
    name: json["product_name"],
    rating: double.parse(json["rating"]),
    tags: json["tags"].toString().split(", "),
    price: double.parse(json["price"]),
    sizes: json["sizes"].toString().split(", "),
    colors: json["colors"].toString().split(", "),
    description: json['description'],
    image: json['image'],
    category: json['category'],

  );
}