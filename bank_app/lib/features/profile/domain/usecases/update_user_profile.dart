import 'package:bank_app/features/profile/domain/repositories/profile_repository.dart';

class UpdateUserProfile {
  final ProfileRepository repository;

  UpdateUserProfile(this.repository);

  Future<void> call({required String email, required String phone}) {
    return repository.updateUserProfile(email: email, phone: phone);
  }
}
