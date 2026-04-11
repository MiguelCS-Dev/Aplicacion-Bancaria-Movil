import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/transfer.dart';
import '../../domain/usecases/get_user_by_account.dart';
import '../../domain/usecases/make_transfer.dart';

import 'dart:async';
import 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  final GetUserByAccount getUserByAccount;
  final MakeTransfer makeTransfer;
  Timer? _debounce;

  TransferCubit({required this.getUserByAccount, required this.makeTransfer})
    : super(const TransferState());

  Future<void> fetchUser(String accountNumber) async {
    try {
      final user = await getUserByAccount(accountNumber);
      emit(state.copyWith(user: user, error: ''));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), user: null));
    }
  }

  void updateAmount(String value) {
    final amount = double.tryParse(value) ?? 0;
    emit(state.copyWith(amount: amount));
  }

  void updateNote(String value) {
    emit(state.copyWith(note: value));
  }

  void onAccountChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchUser(value);
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  Future<String?> submitTransfer(String fromAccount) async {
    if (state.user == null) {
      emit(state.copyWith(error: 'User not selected'));
      return null;
    }

    emit(state.copyWith(isLoading: true, error: ''));

    try {
      final transfer = Transfer(
        fromAccount: fromAccount,
        toAccount: state.user!.accountNumber,
        amount: state.amount,
        note: state.note,
      );

      final transactionId = await makeTransfer(transfer);

      emit(state.copyWith(isLoading: false, transferSuccess: true));

      return transactionId;
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
      return null;
    }
  }
}
