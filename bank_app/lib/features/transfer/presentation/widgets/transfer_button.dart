import 'package:bank_app/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:bank_app/features/transfer/presentation/bloc/transfer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransferButton extends StatelessWidget {
  final String fromAccount;

  const TransferButton({super.key, required this.fromAccount});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferCubit, TransferState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state.isLoading
                ? null
                : () {
                    context.read<TransferCubit>().submitTransfer(fromAccount);
                  },
            child: state.isLoading
                ? const CircularProgressIndicator()
                : const Text('Transferir'),
          ),
        );
      },
    );
  }
}
