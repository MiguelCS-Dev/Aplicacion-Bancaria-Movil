import 'dart:async';

import 'package:bank_app/features/transaction/domain/entities/transaction.dart';
import 'package:bank_app/features/transaction/domain/usecases/get_transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final GetTransactions getTransactions;

  List<Transactio> _transactions = [];
  bool isLoadingMore = false;
  bool hasMore = true;
  String _filter = 'all';

  TransactionCubit(this.getTransactions) : super(TransactionInitial());

  Future<void> loadTransactions(String userId) async {
    emit(TransactionLoading());

    hasMore = true;
    _transactions.clear();

    final data = await getTransactions(userId: userId, filter: _filter);

    _transactions = data;

    emit(
      TransactionLoaded(
        transactions: _transactions,
        filter: _filter,
        isLoadingMore: false,
      ),
    );
  }

  Future<void> loadMore(String userId) async {
    if (!hasMore || isLoadingMore) return;

    isLoadingMore = true;

    if (state is TransactionLoaded) {
      emit(
        TransactionLoaded(
          transactions: _transactions,
          filter: _filter,
          isLoadingMore: true,
        ),
      );
    }

    final more = await getTransactions(
      userId: userId,
      filter: _filter,
      loadMore: true,
    );

    if (more.isEmpty) {
      hasMore = false;
    }

    _transactions.addAll(more);

    emit(
      TransactionLoaded(
        transactions: _transactions,
        filter: _filter,
        isLoadingMore: false,
      ),
    );

    isLoadingMore = false;
  }

  Future<void> refresh(String userId) async {
    _transactions.clear();
    await loadTransactions(userId);
  }

  Future<void> changeFilter(String userId, String newFilter) async {
    _filter = newFilter;
    _transactions.clear();
    await loadTransactions(userId);
  }
}
