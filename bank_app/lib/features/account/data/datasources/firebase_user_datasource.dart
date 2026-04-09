import 'package:bank_app/features/account/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseUserDataSource(this.auth, this.firestore);

  Future<UserModel?> getUser() async {
    final user = auth.currentUser;
    if (user == null) return null;

    final doc = await firestore.collection('users').doc(user.uid).get();

    if (!doc.exists) return null;

    return UserModel.fromFirestore(user.uid, doc.data()!);
  }
}
