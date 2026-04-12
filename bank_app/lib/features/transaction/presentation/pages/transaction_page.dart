import 'package:bank_app/core/themes/app_colors.dart';
import 'package:bank_app/features/transaction/presentation/utils/group_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      context.read<TransactionCubit>().loadTransactions(user.uid);
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (user != null) {
          context.read<TransactionCubit>().loadMore(user.uid);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: Text('Please log in')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction History',
          style: TextStyle(color: white),
        ),
        backgroundColor: primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: white),
          onPressed: () {
            context.go('/home');
          },
        ),
      ),
      backgroundColor: primary,
      body: Column(
        children: [
          TransactionFilter(
            onFilterChanged: (filter) {
              context.read<TransactionCubit>().changeFilter(user.uid, filter);
            },
          ),
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

                  final grouped = groupTransactionsByDate(state.transactions);
                  final sections = grouped.entries.toList();

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: sections.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= sections.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final section = sections[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Text(
                              section.key,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: white,
                              ),
                            ),
                          ),
                          ...section.value.map(
                            (tx) => TransactionCard(transaction: tx),
                          ),
                        ],
                      );
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
