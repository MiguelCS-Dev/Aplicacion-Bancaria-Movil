import 'package:bank_app/features/auth/domain/repositories/auth.repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<void> call(String email, String password, String name) {
    return repository.register(email, password, name);
  }
}