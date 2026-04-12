import 'package:bank_app/features/transfer/domain/usecases/get_current_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/transfer.dart';
import '../../domain/usecases/get_user_by_account.dart';
import '../../domain/usecases/make_transfer.dart';

import 'dart:async';
import 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  final GetUserByAccount getUserByAccount;
  final MakeTransfer makeTransfer;
  final GetCurrentUser getCurrentUser;

  Timer? _debounce;

  TransferCubit({
    required this.getUserByAccount,
    required this.makeTransfer,
    required this.getCurrentUser,
  }) : super(TransferState.initial());

  void onAccountChanged(String value) {
    emit(state.copyWith(user: null, accountError: null));

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (value.length < 10) {
      emit(state.copyWith(accountError: 'Invalid account number'));
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchUser(value);
    });
  }

  Future<void> fetchUser(String accountNumber) async {
    if (accountNumber.isEmpty) return;

    if (accountNumber.length < 10) {
      emit(state.copyWith(accountError: 'Invalid account number'));
      return;
    }

    try {
      final user = await getUserByAccount(accountNumber);

      emit(state.copyWith(user: user, accountError: null));
    } catch (e) {
      emit(state.copyWith(user: null, accountError: 'User not found'));
    }
  }

  void updateAmount(String value) {
    final amount = double.tryParse(value);

    if (amount == null || amount <= 0) {
      emit(state.copyWith(amount: 0, amountError: 'Enter a valid amount'));
      return;
    }

    emit(state.copyWith(amount: amount, amountError: null));
  }

  void updateNote(String value) {
    emit(state.copyWith(note: value));
  }

  Future<String?> submitTransfer() async {
    if (state.user == null) {
      emit(state.copyWith(error: 'Select a valid user'));
      return null;
    }

    if (state.amount <= 0) {
      emit(state.copyWith(error: 'Invalid amount'));
      return null;
    }

    emit(state.copyWith(isLoading: true, error: ''));

    try {
      final currentUser = await getCurrentUser();

      if (currentUser.balance < state.amount) {
        emit(state.copyWith(isLoading: false, error: 'Insufficient balance'));
        return null;
      }

      final transfer = Transfer(
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
