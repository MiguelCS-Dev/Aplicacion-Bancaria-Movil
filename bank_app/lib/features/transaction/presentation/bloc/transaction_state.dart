import 'package:bank_app/features/transaction/domain/entities/transaction.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transactio> transactions;
  final String filter;

  TransactionLoaded({required this.transactions, required this.filter});
}

class TransactionError extends TransactionState {
  final String message;

  TransactionError(this.message);
}
