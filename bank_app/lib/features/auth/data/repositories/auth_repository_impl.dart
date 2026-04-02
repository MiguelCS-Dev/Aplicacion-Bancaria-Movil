
import 'package:bank_app/features/auth/domain/repositories/auth.repository.dart';
import '../datasources/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<void> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<void> register(String email, String password, String name) {
    return dataSource.register(email, password, name);
  }

  @override
  Future<void> resetPassword(String email) {
    return dataSource.resetPassword(email);
  }

  @override
  bool isLoggedIn() {
    return dataSource.isLoggedIn();
  }

  @override
  Future<void> logout() {
    return dataSource.logout();
  }
}