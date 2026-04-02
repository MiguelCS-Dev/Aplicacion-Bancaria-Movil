import 'package:flutter/material.dart';
import 'package:bank_app/core/themes/app_colors.dart';

class BottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 10, offset: Offset(0, -2))
        ],
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: Colors.white,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildItem(Icons.home, 'Home', 0),
              _buildItem(Icons.wallet, 'Account', 1),
              const SizedBox(width: 40),
              _buildItem(Icons.folder, 'Apply', 3),
              _buildItem(Icons.more_horiz, 'More', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(IconData icon, String label, int index) {
    final isSelected = selectedIndex == index;
    final color = isSelected ? primary : Colors.grey;

    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}

