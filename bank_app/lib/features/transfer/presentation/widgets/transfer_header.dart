import 'package:flutter/material.dart';

class TransferHeader extends StatelessWidget {
  const TransferHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.sync_alt, size: 40, color: Colors.white),
        ),
        const SizedBox(height: 16),
        const Text(
          "Transfer Money",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
