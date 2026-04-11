import 'package:flutter/material.dart';
import '../../domain/entities/user_account.dart';

class UserPreviewCard extends StatelessWidget {
  final UserAccount user;

  const UserPreviewCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(user.name),
        subtitle: Text('Tel: ${user.phone}'),
      ),
    );
  }
}
