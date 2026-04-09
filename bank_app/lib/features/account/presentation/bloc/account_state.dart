import 'package:bank_app/features/account/domain/entities/account_summary.dart';

import '../../domain/entities/user_entity.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final UserEntity user;
  final AccountSummaryEntity summary;

  AccountLoaded(this.user, this.summary);
}

class AccountError extends AccountState {
  final String message;

  AccountError(this.message);
}

class AccountSummaryLoaded extends AccountState {
  final AccountSummaryEntity summary;

  AccountSummaryLoaded(this.summary);
}
