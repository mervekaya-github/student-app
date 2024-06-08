import 'package:flutter/material.dart';
import 'package:student_app/screens/login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800], // Ana renk
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.lightBlue[300], // Aksan rengi
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}