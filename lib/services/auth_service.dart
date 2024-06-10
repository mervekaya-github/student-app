import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> signOut() async {
    return await _firebaseService.auth.signOut();
  }
}
