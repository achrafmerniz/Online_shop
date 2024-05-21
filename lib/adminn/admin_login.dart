import 'dart:convert';

import 'package:clothes_app/admin/admin_upload_items.dart';
import 'package:clothes_app/api_connection/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../users/authentification/login_screen.dart';
import 'admin_screen.dart'; // Import the Login Screen

class AdminnLoginScreen extends StatefulWidget {
  const AdminnLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminnLoginScreen> createState() => _AdminnLoginScreenState();
}

class _AdminnLoginScreenState extends State<AdminnLoginScreen> {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObscure = true.obs;

  loginAdminNow() async {
    try {
      var res = await http.post(
        Uri.parse(API.signUpAdmin),
        body: {
          "email_admin": emailController.text.trim(),
          "password_admin": passwordController.text.trim(),
        },
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success'] == true) {
          Fluttertoast.showToast(
              msg: "Dear admin, you are logged-in Successfully.");

          Future.delayed(const Duration(milliseconds: 2000), () {
            Get.to(AdminScreen());
          });
        } else {
          Fluttertoast.showToast(
              msg:
                  "Incorrect Credentials.\nPlease write correct password or email and Try Again.");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "You are not admin");
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
              colors: [
                Colors.orange.shade900,
                Colors.orange.shade600,
                Colors.orange.shade300
              ],
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
                    "Admin Login",
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
                        TextFormField(
                          controller: emailController,
                          validator: (val) =>
                              val == "" ? "Please enter your email" : null,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email,
                                color: Colors.orange.shade900),
                            hintText: "Email.....",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),
                        SizedBox(height: 16),
                        Obx(
                          () => TextFormField(
                            controller: passwordController,
                            obscureText: isObscure.value,
                            validator: (val) =>
                                val == "" ? "Please enter your password" : null,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.vpn_key_sharp,
                                  color: Colors.orange.shade900),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  isObscure.value = !isObscure.value;
                                },
                                child: Icon(
                                  isObscure.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.orange.shade900,
                                ),
                              ),
                              hintText: "Password.....",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Material(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                loginAdminNow();
                              }
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 28,
                              ),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  SizedBox(height: 16),
                  // Add Text and Button for navigating back to normal Login screen
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a Admin?",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    TextButton(
                    onPressed: () {
                      Get.to(LoginScreen());
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
                  ),
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
