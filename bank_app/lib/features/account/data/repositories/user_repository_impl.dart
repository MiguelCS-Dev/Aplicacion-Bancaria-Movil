import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/firebase_user_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseUserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity?> getCurrentUser() async {
    return await dataSource.getUser();
  }
}
