import 'package:flutter/material.dart';
import '../../domain/entities/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transactio transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isDebit = transaction.type == 'debit';

    return ListTile(
      title: Text(transaction.description),
      subtitle: Text(transaction.category),
      trailing: Text(
        '${isDebit ? '-' : '+'}\$${transaction.amount}',
        style: TextStyle(color: isDebit ? Colors.red : Colors.green),
      ),
    );
  }
}
