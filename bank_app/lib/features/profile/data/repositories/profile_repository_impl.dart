import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../models/user_model.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final FirebaseFirestore firestore;
  final firebase_auth.FirebaseAuth auth;

  ProfileRepositoryImpl(this.firestore, this.auth);

  @override
  Future<AppUser> getUserProfile() async {
    final firebase_auth.User firebaseUser = auth.currentUser!;

    final doc = await firestore.collection('users').doc(firebaseUser.uid).get();

    final data = doc.data();

    if (data == null) {
      throw Exception("User data is null");
    }

    return AppUserModel.fromJson(data);
  }

  @override
  Future<void> updateUserProfile({
    required String email,
    required String phone,
  }) async {
    final firebase_auth.User firebaseUser = auth.currentUser!;

    await firestore.collection('users').doc(firebaseUser.uid).update({
      'email': email,
      'phone': phone,
    });

    await firebaseUser.updateEmail(email);
  }
}
