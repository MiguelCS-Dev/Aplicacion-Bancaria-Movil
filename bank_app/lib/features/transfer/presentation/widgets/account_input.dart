import 'package:bank_app/core/themes/inputs_decoration.dart';
import 'package:bank_app/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInput extends StatelessWidget {
  const AccountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: buildInputDecoration(
        label: "Account Number",
        icon: Icons.credit_card,
      ),

      onChanged: (value) {
        context.read<TransferCubit>().onAccountChanged(value);
      },
    );
  }
}
