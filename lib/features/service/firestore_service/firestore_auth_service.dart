import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUserProfile(
    String uid,
    String displayName,
    String email,
    String imgUrl,
    String organization,
    String number,
    String about,
  ) async {
    return _firestore.collection('users').doc(uid).set({
      'displayName': displayName,
      'email': email,
      'imgUrl': imgUrl,
      'organization': organization,
      'number': number,
      'about': about,
    });
  }

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').doc(uid).get();

    return snapshot.data();
  }
}
