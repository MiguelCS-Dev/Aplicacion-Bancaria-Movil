import 'package:flutter/material.dart';
import 'package:bank_app/core/themes/app_colors.dart';
import 'package:go_router/go_router.dart';

class ActionItem {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback? onTap;

  const ActionItem({
    required this.icon,
    required this.label,
    required this.iconColor,
    this.onTap,
  });
}

List<ActionItem> getActionItems(BuildContext context) {
  return [
    ActionItem(
      icon: Icons.sync_alt,
      label: 'Transfer',
      iconColor: primary,
      onTap: () {
        context.push('/transfer');
      },
    ),
    ActionItem(
      icon: Icons.wallet_outlined,
      label: 'Payment',
      iconColor: primary,
    ),
    ActionItem(
      icon: Icons.shopping_cart_outlined,
      label: 'Shop',
      iconColor: primary,
    ),
    ActionItem(icon: Icons.apps, label: 'Other', iconColor: primary),
  ];
}
