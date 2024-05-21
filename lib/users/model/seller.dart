class Seller
{
  int admin_id;
  String admin_name;
  String admin_email;
  String admin_password;

  Seller(
      this.admin_id,
      this.admin_name,
      this.admin_email,
      this.admin_password,
  );

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    int.parse(json["user_id"]),
    json["user_name"],
    json["user_email"],
    json["user_password"],
  );

  Map<String, dynamic> toJson() =>
      {
        'admin_id': admin_id.toString(),
        'admin_name': admin_name,
        'admin_email': admin_email,
        'admin_password': admin_password,
      };
}
