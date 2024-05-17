import 'dart:convert';
import 'package:clothes_app/admin/admin_login.dart';
import 'package:clothes_app/users/authentification/SignUp_screen.dart';
import 'package:clothes_app/api_connection/api_connection.dart';
import 'package:clothes_app/users/fragments/dashboard_of_fragments.dart';
import '../model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../userPreferences/user_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObscure = true.obs;

  Future<void> loginUserNow() async {
    try {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "user_email": emailController.text.trim(),
          "user_password": passwordController.text.trim(),
        },
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success'] == true) {
          Fluttertoast.showToast(msg: "You are logged-in successfully.");

          User userInfo = User.fromJson(resBodyOfLogin["userData"]);

          // Save userInfo to local Storage using Shared Preferences
          await RememberUserPrefs.storeUserInfo(userInfo);

          await Future.delayed(Duration(milliseconds: 2000), () {
            Get.to(DashboardOfFragments());
          });
        } else {
          Fluttertoast.showToast(
              msg: "Incorrect credentials.\nPlease write correct password or email and try again.");
        }
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "An error occurred. Please try again.");
      print("Error :: " + errorMsg.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade900, Colors.orange.shade600, Colors.orange.shade300],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8, // Adjusted width
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900,
                    ),
                  ),
                  SizedBox(height: 24),
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        // Email Field
                        TextFormField(
                          controller: emailController,
                          validator: (val) => val == "" ? "Please enter your email" : null,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.orange.shade900),
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),
                        SizedBox(height: 16),
                        // Password Field
                        Obx(
                          () => TextFormField(
                            controller: passwordController,
                            obscureText: isObscure.value,
                            validator: (val) => val == "" ? "Please enter your password" : null,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock, color: Colors.orange.shade900),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  isObscure.value = !isObscure.value;
                                },
                                child: Icon(
                                  isObscure.value ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.orange.shade900,
                                ),
                              ),
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        // Login Button
                        Material(
                          color: Colors.orange.shade900,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                loginUserNow();
                              }
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(SignUpScreen());
                        },
                        child: Text(
                          "Register Here",
                          style: TextStyle(
                            color: Colors.orange.shade900,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('OR', style: TextStyle(fontSize: 16, color: Colors.black)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Are you an admin?',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(AdminLoginScreen());
                        },
                        child: Text(
                          "Click Here",
                          style: TextStyle(
                            color: Colors.orange.shade900,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
