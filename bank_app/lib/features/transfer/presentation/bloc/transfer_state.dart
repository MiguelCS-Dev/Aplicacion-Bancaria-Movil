import 'package:equatable/equatable.dart';

import '../../domain/entities/user_account.dart';

class TransferState extends Equatable {
  final bool isLoading;
  final bool transferSuccess;
  final String error;

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
  });

  TransferState copyWith({
    bool? isLoading,
    bool? transferSuccess,
    String? error,
    UserAccount? user,
    double? amount,
    String? note,
  }) {
    return TransferState(
      isLoading: isLoading ?? this.isLoading,
      transferSuccess: transferSuccess ?? this.transferSuccess,
      error: error ?? this.error,
      user: user ?? this.user,
      amount: amount ?? this.amount,
      note: note ?? this.note,
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
  ];
}
