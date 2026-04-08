import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/transaction.dart';

class TransactionModel extends Transactio {
  TransactionModel({
    required super.id,
    required super.type,
    required super.description,
    required super.category,
    required super.amount,
    super.date,
    super.note,
    super.recipient,
    super.sender,
  });

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return TransactionModel(
      id: doc.id,
      type: data['type'] ?? 'debit',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
      date: (data['timestamp'] as Timestamp?)?.toDate(),
      note: data['note'],
      recipient: data['recipient'],
      sender: data['sender'],
    );
  }
}
