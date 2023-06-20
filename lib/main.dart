import 'package:flutter/material.dart';
import 'Screens/login_screen.dart';
import 'Screens/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
      //home: MyHomePage(),
    );
  }
}
