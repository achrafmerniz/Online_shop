import 'package:clothes_app/home_view.dart';
import 'package:clothes_app/users/authentification/SignUp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObscure = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          
          Container(
            color: Colors.orange.shade800,
          ),

          // Your login content
          LayoutBuilder(
            builder: (context, cons) {
              return ConstrainedBox(
                constraints: BoxConstraints(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                        vertical: 250, ),
                        child: Container(
                         height: 600,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                             topRight: Radius.circular(60),
                              
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 50, 30, 8.0),
                            child: Column(
                              children: [
                                Form(
                                  key: formkey,
                                  child: Column(
                                    children: [
                                      //email
                                      TextFormField(
                                        controller: emailController,
                                        validator: (val) =>
                                            val == "" ? "Please enter your email" : null,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.email,
                                            color: Colors.orange,
                                          ),
                                          hintText: "Email.....",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.orange,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.orange,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.orange,
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.orange,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 6,
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Obx(
                                        () => TextFormField(
                                          controller: passwordController,
                                          obscureText: isObscure.value,
                                          validator: (val) =>
                                              val == "" ? "Please enter your password" : null,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.vpn_key_sharp,
                                              color: Colors.orange,
                                            ),
                                            suffixIcon: Obx(
                                              () => GestureDetector(
                                                onTap: () {
                                                  isObscure.value = !isObscure.value;
                                                },
                                                child: Icon(
                                                  isObscure.value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                            hintText: "Password.....",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.orange,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.orange,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.orange,
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.orange,
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 6,
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                      Material(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(30),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => HomePage()),
                                        );
                                          },
                                          borderRadius: BorderRadius.circular(30),
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
                                SizedBox(height: 16,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Dont have an account?',
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                                        );
                                      },
                                      child: Text(
                                        "Register Here",
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text('OR', style: TextStyle(fontSize: 16,color: Colors.black),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Are you an admin?',
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                      onPressed: (){},
                                      child: Text(
                                        "Click Here",
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
        
