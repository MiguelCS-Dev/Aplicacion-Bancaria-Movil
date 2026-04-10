import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class FirebaseProfileDataSource {
  final FirebaseFirestore firestore;
  final firebase_auth.FirebaseAuth auth;

  FirebaseProfileDataSource(this.firestore, this.auth);

  Future<Map<String, dynamic>> getUserData() async {
    final user = auth.currentUser!;

    final doc = await firestore.collection('users').doc(user.uid).get();

    final data = doc.data();

    if (data == null) {
      throw Exception("User data is null");
    }

    return data;
  }

  Future<void> updateUserProfile({
    required String email,
    required String phone,
  }) async {
    final user = auth.currentUser!;

    await firestore.collection('users').doc(user.uid).update({
      'email': email,
      'phone': phone,
    });

    await user.updateEmail(email);
  }
}
