import 'package:flutter/material.dart';
import '/loginPage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MainBody();
  }
}

class MainBody extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("Assets/images/tempo.jpg",fit: BoxFit.cover,)),
        splashIconSize: 230,
        nextScreen: Login(),
        backgroundColor: Colors.black,
        splashTransition: SplashTransition.fadeTransition,
        duration: 3000,
      )
    );
  }
}
