import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String fullName;

  const ProfileHeader({super.key, required this.fullName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
        const SizedBox(height: 10),
        Text(
          fullName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
