import 'package:flutter/material.dart';
import '../../domain/entities/transaction_receipt.dart';

class ReceiptCard extends StatelessWidget {
  final TransactionReceipt receipt;

  const ReceiptCard({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    final isDebit = receipt.type == 'debit';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(isDebit ? 'Payment Sent' : 'Payment Received'),
          Text('\$${receipt.amount.toStringAsFixed(2)}'),
          const SizedBox(height: 10),
          Text(receipt.description),
        ],
      ),
    );
  }
}
