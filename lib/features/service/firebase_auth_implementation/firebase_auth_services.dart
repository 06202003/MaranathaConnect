import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../global/common/toast.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

Future<User?> signUpWithEmailAndPassword(
  String username,
  String email,
  String password,
  String imgUrl,
  String organization,
  String number,
) async {
  try {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Add code to store user profile information to Firebase
    await updateUserProfile(
      credential.user!.uid,
      username,
      email,
      imgUrl,
      organization,
      number,
    );

    return credential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      showToast(message: 'The email address is already in use.');
    } else {
      showToast(message: 'An error occurred: ${e.code}');
    }
  }
  return null;
}


  Future<void> updateUserProfile(
    String uid,
    String displayName,
    String email,
    String imgUrl,
    String organization,
    String number,
  ) async {
    return _firestore.collection('users').doc(uid).set({
      'displayName': displayName,
      'email': email,
      'imgUrl': imgUrl,
      'organization': organization,
      'number': number,
    });
  }

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').doc(uid).get();

    return snapshot.data();
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      showToast(message: 'An error occurred while signing out: $e');
    }
  }
}
