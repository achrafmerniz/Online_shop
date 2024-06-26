import 'package:clothes_app/Splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Online shop app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primarySwatch: Colors.blue,
      ),
      
      home:FutureBuilder(
          future: /*RememberUserPrefs.readUserInfo(),*/
          null, builder: (context,dataSnapShot){
        /*if(dataSnapShot.data == null)
        {
        return LoginScreen();
        }
        else
        {
        return DashboardOfFragments();
        } */
        return SplashScreen();
      })
    );
  }
}

