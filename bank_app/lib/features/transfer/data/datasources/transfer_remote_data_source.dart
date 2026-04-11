import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_account_model.dart';
import '../models/transfer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class TransferRemoteDataSource {
  Future<UserAccountModel> getUserByAccount(String accountNumber);
  Future<void> makeTransfer(TransferModel transfer);
}

class TransferRemoteDataSourceImpl implements TransferRemoteDataSource {
  final FirebaseFirestore firestore;

  TransferRemoteDataSourceImpl(this.firestore);

  @override
  Future<UserAccountModel> getUserByAccount(String accountNumber) async {
    final cleanAccount = accountNumber.trim();

    final result = await firestore
        .collection('users')
        .where('account_number', isEqualTo: cleanAccount)
        .limit(1)
        .get();

    if (result.docs.isEmpty) {
      throw Exception('User not found');
    }

    final data = result.docs.first.data();

    return UserAccountModel.fromJson(data);
  }

  @override
  Future<void> makeTransfer(TransferModel transfer) async {
    final firestore = FirebaseFirestore.instance;
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await firestore.runTransaction((transaction) async {
      final fromDocRef = firestore.collection('users').doc(uid);
      final fromSnapshot = await transaction.get(fromDocRef);

      if (!fromSnapshot.exists) {
        throw Exception('Sender not found');
      }

      final fromData = fromSnapshot.data()!;

      final toQuery = await firestore
          .collection('users')
          .where('account_number', isEqualTo: transfer.toAccount)
          .limit(1)
          .get();

      if (toQuery.docs.isEmpty) {
        throw Exception('Receiver not found');
      }

      final toDoc = toQuery.docs.first;
      final toData = toDoc.data();

      final fromAccountNumber = fromData['account_number'].toString();
      final toAccountNumber = toData['account_number'].toString();

      if (fromAccountNumber == toAccountNumber) {
        throw Exception('Cannot transfer to yourself');
      }

      final fromBalance = (fromData['account_balance'] as num).toDouble();
      final toBalance = (toData['account_balance'] as num).toDouble();

      if (fromBalance < transfer.amount) {
        throw Exception('Insufficient balance');
      }

      final newFromBalance = fromBalance - transfer.amount;
      final newToBalance = toBalance + transfer.amount;

      transaction.update(fromDocRef, {'account_balance': newFromBalance});

      transaction.update(toDoc.reference, {'account_balance': newToBalance});

      final transactionRef = firestore.collection('transactions').doc();

      transaction.set(transactionRef, {
        ...transfer.toJson(),
        'from_uid': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }
}
