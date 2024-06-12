import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_app/screens/chat_screen.dart';
import 'package:student_app/services/chat_service.dart';
import 'package:student_app/services/firebase_service.dart';
import '../models/chat.dart';

class ClassmatesScreen extends StatefulWidget {
  @override
  _ClassmatesScreenState createState() => _ClassmatesScreenState();
}

class _ClassmatesScreenState extends State<ClassmatesScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late ChatService _chatService;

  @override
  void initState() {
    super.initState();
    _chatService = ChatService(FirebaseService());
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        title: const Text('Sınıf Arkadaşlarım'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _db.collection('students').doc(user!.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final department = userData['department'];

          return StreamBuilder<QuerySnapshot>(
            stream: _db.collection('students').where('department', isEqualTo: department).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              final classmates = snapshot.data!.docs;

              return ListView.builder(
                itemCount: classmates.length,
                itemBuilder: (context, index) {
                  final classmate = classmates[index].data() as Map<String, dynamic>;
                  final classmateName = classmate['name'];
                  final classmateUid = classmates[index].id;

                  if (classmateUid == user.uid) return Container(); // Kendini listede gösterme

                  return ListTile(
                    title: Text(classmateName),
                    subtitle: Text(classmate['email']),
                    leading: CircleAvatar(
                      backgroundColor: Colors.lightBlue[100],
                      child: Icon(
                        Icons.person,
                        color: Colors.lightBlue[800],
                      ),
                    ),
                    onTap: () async {
                      final chatId = await _chatService.createChat(user.uid, classmateUid);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            chat: Chat(
                              name: classmateName,
                              profilePic: 'assets/default_profile.png', // Profil resmi yoksa varsayılan resim
                              uid: chatId,
                              message: '', // Varsayılan veya boş bir mesaj
                              time: DateTime.now(), // Varsayılan zaman
                            ),
                            chatService: _chatService,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
