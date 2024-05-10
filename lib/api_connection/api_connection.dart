class API
{
  static const hostConnect = "http://192.168.1.42/api_online_store";
  static const hostConnectUser = "$hostConnect/user";
  static const hostConnectAdmin = "$hostConnect/admin";

  static const validateEmail="$hostConnectUser/validate_email.php";
  static const signUp="$hostConnectUser/signup.php";
   static const login="$hostConnectUser/login.php";

  //login admin
  static const adminLogin="$hostConnectAdmin/login.php";
}