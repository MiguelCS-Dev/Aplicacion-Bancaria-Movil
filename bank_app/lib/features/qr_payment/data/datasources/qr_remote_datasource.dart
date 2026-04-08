import 'package:cloud_firestore/cloud_firestore.dart';

abstract class QrPaymentRemoteDataSource {
  Future<void> makePayment({
    required String senderUserId,
    required String receiverUserId,
    required double amount,
    required String receiverUserName,
    required String note,
  });
}

class QrPaymentRemoteDataSourceImpl implements QrPaymentRemoteDataSource {
  final FirebaseFirestore firestore;

  QrPaymentRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> makePayment({
    required String senderUserId,
    required String receiverUserId,
    required double amount,
    required String receiverUserName,
    required String note,
  }) async {
    final batch = firestore.batch();

    final senderDoc = firestore.collection('users').doc(senderUserId);
    final receiverDoc = firestore.collection('users').doc(receiverUserId);

    final senderData = await senderDoc.get();
    final receiverData = await receiverDoc.get();

    if (!senderData.exists || !receiverData.exists) {
      throw Exception('User data not found');
    }

    final senderBalance = (senderData.data()?['account_balance'] ?? 0.0) as num;
    final receiverBalance =
        (receiverData.data()?['account_balance'] ?? 0.0) as num;
    final senderName = senderData.data()?['name'] ?? 'User';

    // Validación
    if (senderBalance < amount) {
      throw Exception('Insufficient balance');
    }

    // Actualizar balances
    batch.update(senderDoc, {'account_balance': senderBalance - amount});

    batch.update(receiverDoc, {'account_balance': receiverBalance + amount});

    final transactionId = firestore.collection('transactions').doc().id;
    final timestamp = FieldValue.serverTimestamp();

    // Transacción sender
    batch.set(
      firestore.collection('transactions').doc('${transactionId}_sender'),
      {
        'userId': senderUserId,
        'type': 'debit',
        'amount': amount,
        'description': 'QR Payment to $receiverUserName',
        'note': note.isNotEmpty ? note : null,
        'recipient': receiverUserName,
        'recipientId': receiverUserId,
        'timestamp': timestamp,
        'category': 'QR Payment',
      },
    );

    // Transacción receiver
    batch.set(
      firestore.collection('transactions').doc('${transactionId}_receiver'),
      {
        'userId': receiverUserId,
        'type': 'credit',
        'amount': amount,
        'description': 'QR Payment from $senderName',
        'note': note.isNotEmpty ? note : null,
        'sender': senderName,
        'senderId': senderUserId,
        'timestamp': timestamp,
        'category': 'QR Payment',
      },
    );

    await batch.commit();
  }
}
