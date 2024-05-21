

class Category
{
  int? id_category;
  String? name;
  
  Category({
    this.id_category,
    this.name,
    
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id_category: int.parse(json["id_category"]),
    name: json["name_category"],
   
  );
}