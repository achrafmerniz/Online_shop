class API
{
  static const hostConnect = "http://192.168.1.36/api_online_store";
  static const hostConnectUser = "$hostConnect/user";
  static const hostConnectAdmin = "$hostConnect/admin";
  static const hostUploadItem = "$hostConnect/items";
  static const hostClothes = "$hostConnect/clothes";
  static const hostCart = "$hostConnect/cart";
  //singup-Login user
  static const validateEmail="$hostConnectUser/validate_email.php";
  static const signUp="$hostConnectUser/signup.php";
  static const login="$hostConnectUser/login.php";

  //login admin
  static const adminLogin="$hostConnectAdmin/loginAdmin.php";
  //upload-save new item
  static const uploadNewItem="$hostUploadItem/upload.php";

  //Clothes
  static const getTrendingMostPopularClothes = "$hostClothes/trending.php";
  static const getAllClothes = "$hostClothes/all.php";

  //cart
  static const addToCart = "$hostCart/add.php";
  static const getCartList = "$hostCart/read.php";
  static const deleteSelectedItemsFromCartList = "$hostCart/delete.php";
  static const updateItemInCartList = "$hostCart/update.php";
}