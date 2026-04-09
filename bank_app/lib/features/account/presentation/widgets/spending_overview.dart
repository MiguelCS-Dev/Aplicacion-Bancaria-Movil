import 'package:bank_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class SpendingOverview extends StatelessWidget {
  const SpendingOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Spending Overview',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),

          /// TOTAL
          Row(
            children: [
              const Text(
                '\$12,521.10',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(
                'From \$20,000.00',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),

          const SizedBox(height: 15),

          /// PROGRESS BAR
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.75,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          /// CATEGORÍAS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _SpendingCategory(
                color: Colors.black87,
                label: 'Subscription',
                amount: '\$8,221.00',
              ),
              _SpendingCategory(
                color: primary,
                label: 'Friend & Family',
                amount: '\$4,300.10',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SpendingCategory extends StatelessWidget {
  final Color color;
  final String label;
  final String amount;

  const _SpendingCategory({
    required this.color,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.grey[700])),
            Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
