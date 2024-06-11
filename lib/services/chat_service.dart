import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message.dart';
import '../models/chat.dart';
import 'firebase_service.dart';

class ChatService {
  final FirebaseService _firebaseService;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ChatService(this._firebaseService);

  Stream<List<Message>> getMessages(String chatId) {
    return _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Message(
      content: doc['content'],
      sentByMe: doc['senderId'] == _auth.currentUser!.uid,
    ))
        .toList());
  }


  Future<void> sendMessage(String chatId, Message message) async {
    try {
      await _db.collection('chats').doc(chatId).collection('messages').add({
        'senderId': _auth.currentUser!.uid,
        'content': message.content,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  Stream<List<Chat>> getChats() {
    final user = _auth.currentUser;
    return _db
        .collection('chats')
        .where('users', arrayContains: user!.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Chat.fromDocument(doc))
        .toList());
  }
}
