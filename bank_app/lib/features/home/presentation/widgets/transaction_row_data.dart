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
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 15),

          /// detalles
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.category,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          /// monto
          Text(
            '${isDebit ? '-' : '+'}\$${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
