import '../../domain/entities/user_entity.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final UserEntity user;

  AccountLoaded(this.user);
}

class AccountError extends AccountState {
  final String message;

  AccountError(this.message);
}
