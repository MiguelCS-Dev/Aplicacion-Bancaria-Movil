import 'package:bank_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class InviteFriends extends StatelessWidget {
  const InviteFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [primary, secondary]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          /// TEXTO
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invite Friends',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Invite your friends and earn \$100 each',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          /// ICONO
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.group_add, color: Colors.white, size: 40),
          ),
        ],
      ),
    );
  }
}
