import '../models/chat.dart';
import '../models/message.dart';
import 'firebase_service.dart';

class ChatService {
  final FirebaseService _firebaseService;

  ChatService(this._firebaseService);

  Stream<List<Chat>> getChats() {
    return _firebaseService.db.collection('chats').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Chat(
            name: doc['name'],
            message: doc['message'],
            time: doc['time'],
            profilePic: doc['profilePic']
        )).toList()
    );
  }

  Stream<List<Message>> getMessages(String chatId) {
    return _firebaseService.db.collection('chats').doc(chatId).collection('messages').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Message(
            content: doc['content'],
            sentByMe: doc['sentByMe']
        )).toList()
    );
  }

  Future<void> sendMessage(String chatId, Message message) {
    return _firebaseService.db.collection('chats').doc(chatId).collection('messages').add({
      'content': message.content,
      'sentByMe': message.sentByMe
    });
  }
}
