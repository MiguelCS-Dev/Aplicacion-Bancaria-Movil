abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> register(String email, String password, String name);
  Future<void> resetPassword(String email);
  bool isLoggedIn();
  Future<void> logout();
}