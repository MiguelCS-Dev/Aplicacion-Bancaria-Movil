import 'package:bank_app/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInput extends StatelessWidget {
  const AccountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Número de cuenta',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        context.read<TransferCubit>().onAccountChanged(value);
      },
    );
  }
}
