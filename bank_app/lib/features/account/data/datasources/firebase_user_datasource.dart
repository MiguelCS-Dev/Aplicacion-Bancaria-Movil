import 'package:bank_app/features/account/data/models/user_model.dart';
import 'package:bank_app/features/account/domain/entities/account_summary.dart';
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

  Future<AccountSummaryEntity> getAccountSummary() async {
    final user = auth.currentUser;
    if (user == null) throw Exception('No user');

    final snapshot = await firestore
        .collection('transactions')
        .where('userId', isEqualTo: user.uid)
        .get();

    double income = 0;
    double expenses = 0;

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final amount = (data['amount'] ?? 0).toDouble();
      final type = data['type'];

      if (type == 'income' || type == 'credit') {
        income += amount;
      } else if (type == 'expense' || type == 'debit') {
        expenses += amount;
      }
    }

    return AccountSummaryEntity(
      income: income,
      expenses: expenses,
      transactions: snapshot.docs.length,
    );
  }
}
