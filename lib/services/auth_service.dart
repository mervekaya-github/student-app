import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

class AuthService {
  final FirebaseService _firebaseService;

  AuthService(this._firebaseService);

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    UserCredential result = await _firebaseService.auth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    UserCredential result = await _firebaseService.auth.createUserWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  Future<void> registerStudent(String uid, String name, String department, int studentClass, String phone) async {
    await _firebaseService.db.collection('students').doc(uid).set({
      'name': name,
      'department': department,
      'class': studentClass,
      'phone': phone,
      'email': _firebaseService.auth.currentUser!.email,
    });
  }

  Future<void> signOut() async {
    return await _firebaseService.auth.signOut();
  }

  Future<void> sendMessage(String senderId, String receiverId, String message) async {
    await _firebaseService.db.collection('messages').add({
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getMessages(String userId) {
    return _firebaseService.db
        .collection('messages')
        .where('receiverId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}

