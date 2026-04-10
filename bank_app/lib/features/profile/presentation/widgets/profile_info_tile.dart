import 'package:flutter/material.dart';

class ProfileInfoTile extends StatelessWidget {
  final String label;
  final String value;
  final bool isEditable;
  final VoidCallback? onEdit;

  const ProfileInfoTile({
    super.key,
    required this.label,
    required this.value,
    this.isEditable = false,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
      trailing: isEditable
          ? IconButton(icon: const Icon(Icons.edit), onPressed: onEdit)
          : null,
    );
  }
}
