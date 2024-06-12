import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_app/services/firebase_service.dart';
import '../models/message.dart';
import '../models/chat.dart';

class ChatService {
  final FirebaseService _firebaseService;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ChatService(this._firebaseService);

  Future<String> createChat(String userId1, String userId2) async {
    String chatId = userId1.compareTo(userId2) < 0 ? '${userId1}_$userId2' : '${userId2}_$userId1';
    await _db.collection('chats').doc(chatId).set({
      'users': [userId1, userId2],
      'lastMessage': '',
      'timestamp': FieldValue.serverTimestamp(),
    });
    return chatId;
  }


  Stream<List<Message>> getMessages(String chatId) {
    return _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true) // Zaman damgasına göre ters sırada sıralama
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Message.fromDocument(doc))
        .toList());
  }



  Future<void> sendMessage(String chatId, Message message) async {
    try {
      await _db.collection('chats').doc(chatId).collection('messages').add({
        'senderId': message.senderId,
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
