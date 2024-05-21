import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:clothes_app/users/authentification/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  AnimatedSplashScreen(splash: Column(
      children: [
        Center(
          child: SizedBox(
            width: 200, 
            height: 200,
            child:LottieBuilder.asset("assets/Lottie/Animation - 1714493899412.json"), 
          )
          
        )
      ],
    ),nextScreen:const LoginScreen(),
    splashIconSize: 200,
    backgroundColor: Colors.white,);
  }
}
