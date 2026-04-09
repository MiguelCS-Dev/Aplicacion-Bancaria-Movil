import 'package:bank_app/core/themes/app_colors.dart';
import 'package:bank_app/features/transaction/data/models/transaction_mapper.dart';
import 'package:bank_app/features/transaction/data/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transactio transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isDebit = transaction.type == 'debit';

    String formattedDate = '';
    if (transaction.date != null) {
      final now = DateTime.now();
      final txDate = DateTime(
        transaction.date!.year,
        transaction.date!.month,
        transaction.date!.day,
      ); // Solo año/mes/día
      final today = DateTime(now.year, now.month, now.day);
      final difference = today.difference(txDate).inDays;

      if (difference == 0) {
        formattedDate = 'Today';
      } else if (difference == 1) {
        formattedDate = 'Yesterday';
      } else {
        formattedDate = DateFormat('MMM dd, yyyy').format(transaction.date!);
      }
    }

    return Card(
      color: secondary,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () {
          final receipt = (transaction as TransactionModel).toReceiptEntity();
          context.pushNamed('receipt', extra: receipt);
        },
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDebit ? Colors.red.shade50 : Colors.green.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isDebit ? Icons.arrow_downward : Icons.arrow_upward,
            color: isDebit ? Colors.red : Colors.green,
            size: 20,
          ),
        ),
        title: Text(
          transaction.description,
          style: const TextStyle(color: white, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          formattedDate,
          style: const TextStyle(color: secondaryWhite, fontSize: 12),
        ),
        trailing: Text(
          '${isDebit ? '-' : '+'}\$${transaction.amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: isDebit ? Colors.redAccent : Colors.greenAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
