import 'package:bank_app/features/home/presentation/widgets/transaction_row_data.dart';
import 'package:bank_app/features/transaction/presentation/bloc/transaction_cubit.dart';
import 'package:bank_app/features/transaction/presentation/bloc/transaction_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bank_app/core/themes/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'transaction_row.dart';

class TransactionHistorySection extends StatelessWidget {
  const TransactionHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            _buildSectionHeader(context),
            const SizedBox(height: 10),

            BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                return RefreshIndicator(
                  onRefresh: () async {
                    if (user != null) {
                      await context.read<TransactionCubit>().refresh(user.uid);
                    }
                  },

                  child: _buildContent(state),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(TransactionState state) {
    if (state is TransactionLoading) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(3, (_) => const TransactionRow()),
      );
    }

    if (state is TransactionError) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        children: const [
          SizedBox(height: 80),
          Center(child: Text('Error loading transactions')),
        ],
      );
    }

    if (state is TransactionLoaded) {
      final transactions = state.transactions.take(3).toList();

      if (transactions.isEmpty) {
        return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: const [
            SizedBox(height: 80),
            Center(child: Text('No transactions yet')),
          ],
        );
      }

      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        children: transactions
            .map((tx) => TransactionRowData(transaction: tx))
            .toList(),
      );
    }

    return const SizedBox();
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Transaction History',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            context.push('/transactions');
          },
          child: const Text(
            'See All',
            style: TextStyle(color: primary, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
