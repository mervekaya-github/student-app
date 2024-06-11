import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String name;
  final String profilePic;
  final String uid;
  final String message; // Son mesaj
  final DateTime time; // Mesajın gönderilme zamanı

  Chat({
    required this.name,
    required this.profilePic,
    required this.uid,
    required this.message,
    required this.time,
  });

  factory Chat.fromDocument(DocumentSnapshot doc) {
    return Chat(
      name: doc['name'],
      profilePic: doc['profilePic'],
      uid: doc.id,
      message: doc['message'],
      time: (doc['time'] as Timestamp).toDate(),
    );
  }
}
