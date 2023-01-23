import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ui/splash_screen.dart';

void main() {
  //Building and running the main App
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
      ),
      //this line of code will redirect to the SplashScreen
      home: const SplashScreen(),
    );
  }
}
