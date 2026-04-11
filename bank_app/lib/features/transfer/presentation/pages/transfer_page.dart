import 'package:bank_app/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:bank_app/features/transfer/presentation/bloc/transfer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/account_input.dart';
import '../widgets/user_preview_card.dart';
import '../widgets/amount_input.dart';
import '../widgets/transfer_button.dart';

class TransferPage extends StatelessWidget {
  final String fromAccount;

  const TransferPage({super.key, required this.fromAccount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transferencia')),
      body: BlocConsumer<TransferCubit, TransferState>(
        listener: (context, state) {
          if (state.transferSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Transferencia exitosa')),
            );
          }

          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                AccountInput(),

                const SizedBox(height: 16),

                if (state.isLoading) const CircularProgressIndicator(),

                if (state.user != null) UserPreviewCard(user: state.user!),

                const SizedBox(height: 16),

                AmountInput(),

                const Spacer(),

                TransferButton(fromAccount: fromAccount),
              ],
            ),
          );
        },
      ),
    );
  }
}
