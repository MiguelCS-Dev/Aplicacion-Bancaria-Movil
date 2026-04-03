import 'package:bank_app/features/auth/domain/repositories/auth.repository.dart';

class ResetPassword {
  final AuthRepository repository;

  ResetPassword(this.repository);

  Future<void> call(String email) {
    return repository.resetPassword(email);
  }
}