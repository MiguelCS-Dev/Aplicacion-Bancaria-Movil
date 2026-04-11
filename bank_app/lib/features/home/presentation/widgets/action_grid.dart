import 'package:flutter/material.dart';
import 'package:bank_app/features/home/domain/entities/action_item.dart';
import 'action_button.dart';

class ActionGridSection extends StatelessWidget {
  const ActionGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What would you like to do today?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
              children: getActionItems(
                context,
              ).map((item) => ActionButton(item: item)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
