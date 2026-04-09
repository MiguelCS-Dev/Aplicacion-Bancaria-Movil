import 'package:bank_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  final String name;

  const ProfileSection({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [primary, secondary]),
          ),
          child: const Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: 15),
        Text(
          name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
