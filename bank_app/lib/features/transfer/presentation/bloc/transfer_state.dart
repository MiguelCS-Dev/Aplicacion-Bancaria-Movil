import 'package:equatable/equatable.dart';

import '../../domain/entities/user_account.dart';

class TransferState extends Equatable {
  final bool isLoading;
  final bool transferSuccess;
  final String? error;
  final String? accountError;
  final String? amountError;
  final UserAccount? user;
  final double amount;
  final String note;

  const TransferState({
    this.isLoading = false,
    this.transferSuccess = false,
    this.error = '',
    this.user,
    this.amount = 0,
    this.note = '',
    this.accountError,
    this.amountError,
  });

  factory TransferState.initial() => TransferState();

  bool get isValid =>
      user != null &&
      amount > 0 &&
      note.length <= 20 &&
      (accountError == null || accountError!.isEmpty) &&
      (amountError == null || amountError!.isEmpty);

  TransferState copyWith({
    bool? isLoading,
    bool? transferSuccess,
    String? error,
    UserAccount? user,
    double? amount,
    String? note,
    String? accountError,
    String? amountError,
  }) {
    return TransferState(
      isLoading: isLoading ?? this.isLoading,
      transferSuccess: transferSuccess ?? this.transferSuccess,
      error: error ?? this.error,
      user: user ?? this.user,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      accountError: accountError,
      amountError: amountError,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    transferSuccess,
    error,
    user,
    amount,
    note,
    accountError,
    amountError,
  ];
}
