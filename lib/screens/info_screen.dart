import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/screens/chatlist_screen.dart';
import 'package:student_app/services/auth_service.dart';
import 'package:student_app/services/chat_service.dart';
import 'package:student_app/services/firebase_service.dart';
import 'classmates_screen.dart';
import 'login_screen.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? user;
  Map<String, dynamic>? userInfo;
  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    _authService = AuthService(FirebaseService());
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    if (user != null) {
      DocumentSnapshot userDoc = await _db.collection('students').doc(user!.uid).get();
      setState(() {
        userInfo = userDoc.data() as Map<String, dynamic>?;
      });
    }
  }

  void _logout() async {
    await _authService.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50], // Pastel bir arka plan rengi
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800], // Uyumlu renk
        title: const Text('Bilgilerim'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.lightBlue[100],
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.lightBlue[800],
                ),
              ),
              const SizedBox(height: 16),
              userInfo != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('Ad-Soyad', userInfo!['name']),
                  const SizedBox(height: 16),
                  buildInfoRow('Bölüm', userInfo!['department']),
                  const SizedBox(height: 16),
                  buildInfoRow('Sınıf', userInfo!['class'].toString()),
                  const SizedBox(height: 16),
                  buildInfoRow('Telefon', userInfo!['phone']),
                  const SizedBox(height: 32),
                  buildButtonRow(context, 'Sınıf Arkadaşlarım', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClassmatesScreen()),
                    );
                  }),
                  const SizedBox(height: 16),

                ],
              )
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue[800],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.lightBlue[800],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtonRow(BuildContext context, String text, VoidCallback onPressed) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
