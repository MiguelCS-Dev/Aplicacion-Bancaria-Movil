import 'package:bank_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _item(
            context,
            icon: Icons.person_outline,
            title: 'My Account',
            onTap: () {},
          ),
          _divider(),
          _item(
            context,
            icon: Icons.receipt_long_outlined,
            title: 'Transaction History',
            onTap: () => context.go('/transactions'),
          ),
          _divider(),
          _item(
            context,
            icon: Icons.security_outlined,
            title: 'Security Settings',
            onTap: () => context.go('/security'),
          ),
          _divider(),
          _item(
            context,
            icon: Icons.settings_outlined,
            title: 'General Settings',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: primary),
            ),
            const SizedBox(width: 15),
            Expanded(child: Text(title)),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(height: 1),
    );
  }
}
