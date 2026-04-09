import 'dart:async';

import 'package:bank_app/features/transaction/domain/usecases/get_transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final GetTransactions getTransactions;

  StreamSubscription? _subscription;

  String _filter = 'all';

  TransactionCubit(this.getTransactions) : super(TransactionInitial());

  void loadTransactions(String userId) {
    emit(TransactionLoading());

    _subscription?.cancel();

    _subscription = getTransactions(userId: userId, filter: _filter).listen(
      (transactions) {
        emit(TransactionLoaded(transactions: transactions, filter: _filter));
      },
      onError: (error) {
        emit(TransactionError(error.toString()));
      },
    );
  }

  void changeFilter(String userId, String newFilter) {
    _filter = newFilter;
    loadTransactions(userId);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  Future<void> refresh(String userId) async {
    loadTransactions(userId);
  }
}
