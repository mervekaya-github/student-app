import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:student_app/screens/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const LoginScreen(),
    );
  }
}
