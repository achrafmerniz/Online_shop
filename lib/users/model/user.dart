class User{
  int user_id;
  String user_name;
  String user_email;
  String user_password;

  User(
  this.user_id,
  this.user_name,
  this.user_email,
  this.user_password,
);

Map <String,dynamic> toJson()=>
{
  'IDUtilisateur': user_id.toString(),
  'nomUtilisateur': user_name,
  'Email': user_email,
  'MotDePasse': user_password,

};
}
