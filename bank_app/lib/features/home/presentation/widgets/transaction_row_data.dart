import 'package:bank_app/features/transaction/domain/entities/transaction.dart';
import 'package:flutter/material.dart';

class TransactionRowData extends StatelessWidget {
  final Transactio transaction;

  const TransactionRowData({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isDebit = transaction.type == 'debit';

    final icon = isDebit ? Icons.arrow_upward : Icons.arrow_downward;
    final color = isDebit ? Colors.red : Colors.green;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.category,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isDebit
                  ? Colors.red.withValues(alpha: 0.08)
                  : Colors.green.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${isDebit ? '-' : '+'}\$${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(color: color, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
