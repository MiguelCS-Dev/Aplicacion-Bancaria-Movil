import 'package:bank_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AccountSummary extends StatelessWidget {
  final double balance;
  final double income;
  final double expenses;
  final int transactions;

  const AccountSummary({
    super.key,
    required this.balance,
    required this.income,
    required this.expenses,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.1), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account Summary',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 10),

          /// BALANCE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                balance < 0
                    ? 'Overdrawn: \$${balance.toStringAsFixed(2)}'
                    : '\$${balance.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: balance < 0 ? Colors.red : Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                balance < 0 ? 'Negative balance' : 'Available balance',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),

          const SizedBox(height: 15),

          /// DATA ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _item('Income', income, Colors.green),
              _item('Expenses', expenses, Colors.red),
              _item(
                'Transactions',
                transactions.toDouble(),
                primary,
                isCount: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _item(
    String label,
    double value,
    Color color, {
    bool isCount = false,
  }) {
    return Column(
      children: [
        Text(
          isCount ? value.toInt().toString() : '\$${value.toStringAsFixed(0)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
