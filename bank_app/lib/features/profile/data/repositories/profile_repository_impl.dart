import 'package:bank_app/features/profile/data/datasources/firebase_profile_datasource.dart';

import '../models/user_model.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final FirebaseProfileDataSource dataSource;

  ProfileRepositoryImpl(this.dataSource);

  @override
  Future<AppUser> getUserProfile() async {
    final data = await dataSource.getUserData();
    return AppUserModel.fromJson(data);
  }

  @override
  Future<void> updateUserProfile({
    required String email,
    required String phone,
  }) async {
    await dataSource.updateUserProfile(email: email, phone: phone);
  }
}
