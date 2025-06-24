import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<User?> registerWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await result.user?.updateDisplayName(name);
      await result.user?.reload();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .set({
            'uid': result.user!.uid,
            'email': email,
            'name': name,
            'createdAt': Timestamp.now(),
          });

      return _auth.currentUser;
    } catch (e) {
      print('Signup Error: $e');
      return null;
    }
  }

 
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('Login Error: $e');
      return null;
    }
  }

 
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Reset Password Error: $e');
      rethrow;
    }
  }


  Future<void> signOut() async {
    await _auth.signOut();
  }
}
