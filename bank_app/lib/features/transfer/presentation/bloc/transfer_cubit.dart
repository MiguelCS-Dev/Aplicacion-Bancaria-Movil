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

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  TransferCubit({required this.getUserByAccount, required this.makeTransfer})
    : super(const TransferState());

  Future<void> fetchUser(String accountNumber) async {
    if (accountNumber.isEmpty) return;

    emit(state.copyWith(isLoading: true, error: null, user: null));

    try {
      final user = await getUserByAccount(accountNumber);

      emit(state.copyWith(isLoading: false, user: user));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void updateAmount(String value) {
    final amount = double.tryParse(value) ?? 0;

    emit(state.copyWith(amount: amount));
  }

  Future<void> submitTransfer(String fromAccount) async {
    if (state.user == null) {
      emit(state.copyWith(error: 'No user selected'));
      return;
    }

    if (state.user!.accountNumber == fromAccount) {
      emit(state.copyWith(error: 'No puedes transferirte a ti mismo'));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final transfer = Transfer(
        fromAccount: fromAccount,
        toAccount: state.user!.accountNumber,
        amount: state.amount,
      );

      await makeTransfer(transfer);

      emit(state.copyWith(isLoading: false, transferSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void reset() {
    emit(const TransferState());
  }

  void onAccountChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.length >= 6) {
        fetchUser(value);
      }
    });
  }
}
