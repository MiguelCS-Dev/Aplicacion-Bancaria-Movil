import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../bloc/transaction_cubit.dart';
import '../bloc/transaction_state.dart';
import '../widgets/transaction_card.dart';
import '../widgets/transaction_filter.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.read<TransactionCubit>().loadTransactions(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: Text('Please log in')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Transaction History')),
      body: Column(
        children: [
          /// 🔹 FILTROS
          TransactionFilter(
            onFilterChanged: (filter) {
              context.read<TransactionCubit>().changeFilter(user.uid, filter);
            },
          ),

          /// 🔹 LISTA
          Expanded(
            child: BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is TransactionError) {
                  return Center(child: Text(state.message));
                }

                if (state is TransactionLoaded) {
                  if (state.transactions.isEmpty) {
                    return const Center(child: Text('No transactions yet'));
                  }

                  return ListView.builder(
                    itemCount: state.transactions.length,
                    itemBuilder: (context, index) {
                      final tx = state.transactions[index];

                      return TransactionCard(transaction: tx);
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
