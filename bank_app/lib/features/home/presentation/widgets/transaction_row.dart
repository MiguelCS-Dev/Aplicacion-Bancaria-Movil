import 'package:flutter/material.dart';
import 'package:bank_app/core/widgets/skeleton_container.dart';

class TransactionRow extends StatelessWidget {
  const TransactionRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const [
          _IconPlaceholder(),
          SizedBox(width: 15),
          _DetailsPlaceholder(),
          SkeletonContainer(width: 70, height: 16, radius: 4),
        ],
      ),
    );
  }
}

class _IconPlaceholder extends StatelessWidget {
  const _IconPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const SkeletonContainer(width: 24, height: 24, radius: 4),
    );
  }
}

class _DetailsPlaceholder extends StatelessWidget {
  const _DetailsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonContainer(width: 120, height: 16, radius: 4),
          SizedBox(height: 5),
          SkeletonContainer(width: 80, height: 14, radius: 4),
        ],
      ),
    );
  }
}