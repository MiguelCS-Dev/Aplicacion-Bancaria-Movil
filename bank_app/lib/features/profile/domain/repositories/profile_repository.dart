import 'package:bank_app/features/profile/domain/entities/user.dart';

abstract class ProfileRepository {
  Future<AppUser> getUserProfile();
  Future<void> updateUserProfile({
    required String email,
    required String phone,
  });
}
