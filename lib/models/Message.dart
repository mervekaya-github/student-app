import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Message {
  String _content;
  bool _sentByMe;
  String _senderId;

  Message({
    required String content,
    required bool sentByMe,
    required String senderId,
  })  : _content = content,
        _sentByMe = sentByMe,
        _senderId = senderId;

  // Getters
  String get content => _content;
  bool get sentByMe => _sentByMe;
  String get senderId => _senderId;

  // Setters
  set content(String value) {
    _content = value;
  }

  set sentByMe(bool value) {
    _sentByMe = value;
  }

  set senderId(String value) {
    _senderId = value;
  }

  factory Message.fromDocument(DocumentSnapshot doc) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Message(
      content: doc['content'],
      sentByMe: doc['senderId'] == currentUserId,
      senderId: doc['senderId'],
    );
  }
}
