import 'package:flutter/material.dart';
import 'package:bank_app/core/themes/app_colors.dart';
import 'package:go_router/go_router.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: secondary.withValues(alpha: 0.6),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: primary,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildItem(
                context: context,
                icon: Icons.home,
                label: 'Home',
                route: '/home',
                currentRoute: location,
              ),
              _buildItem(
                context: context,
                icon: Icons.wallet,
                label: 'Account',
                route: '/account',
                currentRoute: location,
              ),
              const SizedBox(width: 40),
              _buildItem(
                context: context,
                icon: Icons.swap_horiz,
                label: 'Transfer',
                route: '/transfer',
                currentRoute: location,
              ),
              _buildItem(
                context: context,
                icon: Icons.more_horiz,
                label: 'More',
                route: '/more',
                currentRoute: location,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goTo(BuildContext context, String route) {
    context.go(route);
  }

  Widget _buildItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String route,
    required String currentRoute,
  }) {
    final isSelected = currentRoute == route;
    final color = isSelected
        ? Colors.white
        : Colors.white.withValues(alpha: 0.8);

    return InkWell(
      onTap: () => _goTo(context, route),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
