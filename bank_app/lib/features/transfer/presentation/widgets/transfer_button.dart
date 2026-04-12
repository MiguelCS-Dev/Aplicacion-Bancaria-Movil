import 'package:bank_app/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:bank_app/features/transfer/presentation/bloc/transfer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/themes/app_colors.dart';

class TransferButton extends StatelessWidget {
  final TransferState state;

  const TransferButton({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
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
      child: ElevatedButton(
        onPressed: state.isLoading
            ? null
            : () async {
                final id = await context.read<TransferCubit>().submitTransfer();

                if (id != null && context.mounted) {
                  context.pushNamed('receipt', extra: id);
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: state.isLoading
            ? const CircularProgressIndicator(color: white)
            : const Text(
                "Send Money",
                style: TextStyle(fontWeight: FontWeight.bold, color: white),
              ),
      ),
    );
  }
}
