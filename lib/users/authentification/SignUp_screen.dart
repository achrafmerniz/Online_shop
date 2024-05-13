import 'dart:convert';
import 'package:clothes_app/api_connection/api_connection.dart';
import 'package:clothes_app/users/authentification/login_screen.dart';
import 'package:clothes_app/users/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
 

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  var formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isObscure = true.obs;

  validateUserEmail() async
  {
    try
    {
      var res = await http.post(
        Uri.parse(API.validateEmail),
        body: {
          'user_email': emailController.text.trim(),
        },
      );

      if(res.statusCode == 200) //from flutter app the connection with api to server - success
      {
        var resBodyOfValidateEmail = jsonDecode(res.body);

        if(resBodyOfValidateEmail['emailFound'] == true)
        {
          Fluttertoast.showToast(msg: "Email is already in someone else use. Try another email.");
        }
        else
        {
          //register & save new user record to database
          registerAndSaveUserRecord();
        }
      }
      else
      {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    }
    catch (e) {
  print("Une erreur s'est produite : $e");
  Fluttertoast.showToast(msg: "email matvalidach : $e");
}
  }

  registerAndSaveUserRecord() async
  {
    User userModel = User(
      1,
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    try
    {
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),
      );

      if(res.statusCode == 200) //from flutter app the connection with api to server - success
      {
        var resBodyOfSignUp = jsonDecode(res.body);
        if(resBodyOfSignUp['success'] == true)
        {
          Fluttertoast.showToast(msg: "Congratulations, you are SignUp Successfully.");

          setState(() {
            nameController.clear();
            emailController.clear();
            passwordController.clear();
          });
        }
        else
        {
          Fluttertoast.showToast(msg: "Error Occurred, Try Again.");
        }
      }
      else
      {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    }
    catch(e)
    {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.orange.shade800,
          ),
          // Your login content
          LayoutBuilder(
            builder:(context,cons){
              return ConstrainedBox(
                constraints: BoxConstraints(
                ),
                child: SingleChildScrollView(
                  child:Column(
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 250),
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
                            padding: const EdgeInsets.fromLTRB(30,50,30,8.0),
                            child: Column(
                              children: [
                                Form(
                                   key:formkey,
                                   child: Column(
                                    children: [
                                       TextFormField(
                                        controller: nameController,
                                        validator:(val)=> val=="" ? "plaese enter your Name" : null,
                                        decoration: InputDecoration(
                                          prefixIcon:const Icon(
                                            Icons.person,
                                            color: Colors.orange,
                                          ),
                                          hintText: "Name.....",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide:const BorderSide(
                                              color: Colors.orange,
                                            )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide:const BorderSide(
                                              color: Colors.orange,
                                            )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide:const BorderSide(
                                              color: Colors.orange,
                                            )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide:const BorderSide(
                                              color: Colors.orange,
                                            )
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
                                      //email
                                      TextFormField(
                                        controller: emailController,
                                        validator:(val)=> val=="" ? "plaese enter your email" : null,
                                        decoration: InputDecoration(
                                          prefixIcon:const Icon(
                                            Icons.email,
                                            color: Colors.orange,
                                          ),
                                          hintText: "Email.....",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide:const BorderSide(
                                              color: Colors.orange,
                                            )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide:const BorderSide(
                                              color: Colors.orange,
                                            )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide:const BorderSide(
                                              color: Colors.orange,
                                            )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide:const BorderSide(
                                              color: Colors.orange,
                                            )
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
                                        ()=>TextFormField(
                                        controller: passwordController,
                                        obscureText: isObscure.value,
                                        validator:(val)=> val=="" ? "plaese enter your password" : null,
                                        decoration: InputDecoration(
                                          prefixIcon:const Icon(
                                            Icons.vpn_key_sharp,
                                            color: Colors.orange,
                                          ),
                                          suffixIcon: Obx(
                                            ()=>GestureDetector(
                                              onTap: (){
                                               isObscure.value= !isObscure.value;
                                              },
                                              child: Icon(
                                                isObscure.value ? Icons.visibility_off : Icons.visibility,
                                                color:Colors.orange,
                                              ), 
                                              
                                            )
                                          ),
                                          hintText: "Password.....",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide:const BorderSide(
                                              color: Colors.black,
                                            )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide:const BorderSide(
                                              color: Colors.orange,
                                            )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide:const BorderSide(
                                              color: Colors.orange,
                                            )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide:const BorderSide(
                                              color: Colors.orange,
                                            )
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
                                          onTap: (){
                                          if(formkey.currentState!.validate()){
                                            //validate email
                                            validateUserEmail();
                                          }
                                          },
                                          borderRadius: BorderRadius.circular(30),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 28
                                          ),
                                          child: Text(
                                            "SignUp",
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
                                      'Already have an account?',
                                      style: TextStyle(color:Colors.black,fontWeight:FontWeight.bold),
                                    ),
                                    TextButton(
                                     onPressed: (){
                                      Get.to(LoginScreen());
                                     },
                                     child: Text("Login Here",
                                     style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                     ),))
                                  ],
                                 ),
                                 
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ),
                );
            } ),
        ],
      ),
    );
  }
}
