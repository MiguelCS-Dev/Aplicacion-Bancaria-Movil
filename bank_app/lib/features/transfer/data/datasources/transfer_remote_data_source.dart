import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_account_model.dart';
import '../models/transfer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class TransferRemoteDataSource {
  Future<UserAccountModel> getUserByAccount(String accountNumber);
  Future<String> makeTransfer(TransferModel transfer); // 👈 devuelve ID
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

    return UserAccountModel.fromJson(result.docs.first.data());
  }

  @override
  Future<String> makeTransfer(TransferModel transfer) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    String transactionId = '';

    await firestore.runTransaction((transaction) async {
      final fromRef = firestore.collection('users').doc(uid);
      final fromSnap = await transaction.get(fromRef);

      if (!fromSnap.exists) throw Exception('Sender not found');

      final fromData = fromSnap.data()!;

      final toQuery = await firestore
          .collection('users')
          .where('account_number', isEqualTo: transfer.toAccount)
          .limit(1)
          .get();

      if (toQuery.docs.isEmpty) throw Exception('Receiver not found');

      final toDoc = toQuery.docs.first;
      final toData = toDoc.data();

      final fromBalance = (fromData['account_balance'] as num).toDouble();
      final toBalance = (toData['account_balance'] as num).toDouble();

      if (fromBalance < transfer.amount) {
        throw Exception('Insufficient balance');
      }

      if (fromData['account_number'].toString() ==
          toData['account_number'].toString()) {
        throw Exception('Cannot transfer to yourself');
      }

      final newFromBalance = fromBalance - transfer.amount;
      final newToBalance = toBalance + transfer.amount;

      transaction.update(fromRef, {'account_balance': newFromBalance});

      transaction.update(toDoc.reference, {'account_balance': newToBalance});

      final transactionsRef = firestore.collection('transactions');

      final debitRef = transactionsRef.doc();
      transactionId = debitRef.id;

      transaction.set(debitRef, {
        'amount': transfer.amount,
        'category': 'Transfer',
        'description': 'Transfer to ${toData['name']}',
        'note': transfer.note ?? '',
        'recipient': toData['name'],
        'recipientId': toDoc.id,
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'debit',
        'userId': uid,
      });

      transaction.set(transactionsRef.doc(), {
        'amount': transfer.amount,
        'category': 'Transfer',
        'description': 'Transfer from ${fromData['name']}',
        'note': transfer.note ?? '',
        'recipient': fromData['name'],
        'recipientId': uid,
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'credit',
        'userId': toDoc.id,
      });
    });

    return transactionId;
  }
}
