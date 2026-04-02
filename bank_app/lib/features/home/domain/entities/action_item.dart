import 'package:flutter/material.dart';
import 'package:bank_app/core/themes/app_colors.dart';

class ActionItem {
  final IconData icon;
  final String label;
  final Color iconColor;

  const ActionItem({
    required this.icon,
    required this.label,
    required this.iconColor,
  });
}

const List<ActionItem> actionItems = [
  ActionItem(icon: Icons.sync_alt, label: 'Transfer', iconColor: primary),
  ActionItem(icon: Icons.wallet_outlined, label: 'Payment', iconColor: primary),
  ActionItem(icon: Icons.shopping_cart_outlined, label: 'Shop', iconColor: primary),
  ActionItem(icon: Icons.apps, label: 'Other', iconColor: primary),
];