import 'package:bank_app/features/account/domain/entities/account_summary.dart';

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

  @override
  Future<AccountSummaryEntity> getAccountSummary() async {
    return await dataSource.getAccountSummary();
  }
}
