import 'package:flutter/material.dart';
import 'package:student_app/screens/chatlist_screen.dart';
import 'package:student_app/services/chat_service.dart';
import 'package:student_app/services/firebase_service.dart';
import 'classmates_screen.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50], // Pastel bir arka plan rengi
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800], // Uyumlu renk
        title: const Text('Bilgilerim'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField('Ad-Soyad', 'Ad-Soyad'),
              const SizedBox(height: 16),
              buildTextField('Bölüm', 'Bölüm'),
              const SizedBox(height: 16),
              buildTextField('Sınıf', 'Sınıf'),
              const SizedBox(height: 16),
              buildTextField('Telefon', 'Telefon', keyboardType: TextInputType.phone),
              const SizedBox(height: 32),
              buildButtonRow(context, 'Sınıf Arkadaşlarım', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClassmatesScreen()),
                );
              }),
              const SizedBox(height: 16),
              buildButtonRow(context, 'Mesajlarım', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatListScreen(chatService: ChatService(FirebaseService()))),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, {TextInputType keyboardType = TextInputType.text}) {
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
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.lightBlue[800]),
            ),
            keyboardType: keyboardType,
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
