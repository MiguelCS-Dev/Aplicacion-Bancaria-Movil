import 'package:bank_app/features/auth/domain/repositories/auth.repository.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  bool call() {
    return repository.isLoggedIn();
  }
}