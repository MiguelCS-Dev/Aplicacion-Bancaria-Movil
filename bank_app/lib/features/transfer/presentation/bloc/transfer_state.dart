import '../../domain/entities/user_account.dart';

class TransferState {
  final bool isLoading;
  final UserAccount? user;
  final String? error;
  final double amount;
  final bool transferSuccess;

  const TransferState({
    this.isLoading = false,
    this.user,
    this.error,
    this.amount = 0,
    this.transferSuccess = false,
  });

  TransferState copyWith({
    bool? isLoading,
    UserAccount? user,
    String? error,
    double? amount,
    bool? transferSuccess,
  }) {
    return TransferState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
      amount: amount ?? this.amount,
      transferSuccess: transferSuccess ?? this.transferSuccess,
    );
  }
}
