import 'package:bank_app/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmountInput extends StatelessWidget {
  const AmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Monto',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        context.read<TransferCubit>().updateAmount(value);
      },
    );
  }
}
