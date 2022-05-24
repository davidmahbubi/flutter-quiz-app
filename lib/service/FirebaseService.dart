import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User?> signInAnonymmously() async {
    try {
      _auth.signInAnonymously();
      UserCredential result = await _auth.signInAnonymously();
      User? firebaseUser = result.user;
      return firebaseUser;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<User?> signUpEmailPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return firebaseUser;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<User?> signInEmailPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return firebaseUser;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<User?> firebaseUserStream = _auth.authStateChanges();
}
