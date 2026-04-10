import 'package:bank_app/features/profile/domain/entities/user.dart';
import 'package:bank_app/features/profile/domain/repositories/profile_repository.dart';

class GetUserProfile {
  final ProfileRepository repository;

  GetUserProfile(this.repository);

  Future<AppUser> call() {
    return repository.getUserProfile();
  }
}
