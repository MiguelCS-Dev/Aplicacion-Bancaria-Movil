import 'package:bank_app/features/auth/domain/repositories/auth.repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<void> call(String email, String password) {
    return repository.login(email, password);
  }
}