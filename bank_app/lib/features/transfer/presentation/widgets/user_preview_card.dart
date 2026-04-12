import 'package:bank_app/core/themes/app_colors.dart';
import 'package:bank_app/features/transfer/presentation/bloc/transfer_state.dart';
import 'package:flutter/material.dart';

class UserPreviewCard extends StatelessWidget {
  final TransferState state;

  const UserPreviewCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.user == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [primary, secondary]),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "${state.user!.name} • ${state.user!.phone}",
              style: const TextStyle(fontWeight: FontWeight.w600, color: white),
            ),
          ),
        ],
      ),
    );
  }
}
