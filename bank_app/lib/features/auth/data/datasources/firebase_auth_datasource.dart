import 'package:bank_app/core/widgets/auth_account_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseAuthDataSource(this.auth, this.firestore);

  Future<void> login(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<String> _generateUniqueAccountNumber() async {
    String accountNumber = '';
    bool exists = true;

    while (exists) {
      accountNumber = AccountNumberGenerator.generate();

      final result = await firestore
          .collection('users')
          .where('account_number', isEqualTo: accountNumber)
          .limit(1)
          .get();

      exists = result.docs.isNotEmpty;
    }

    return accountNumber;
  }

  Future<void> register(String email, String password, String name) async {
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await userCredential.user?.updateDisplayName(name);

    if (userCredential.user != null) {
      final accountNumber = await _generateUniqueAccountNumber();

      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'name': name,
        'phone': '',
        'account_balance': 0.0,
        'account_number': accountNumber,
        'card_number_suffix': accountNumber.substring(accountNumber.length - 4),
      });
    }
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
