import 'package:bank_app/features/account/domain/entities/account_summary.dart';
import 'package:bank_app/features/account/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> getCurrentUser();

  Future<AccountSummaryEntity> getAccountSummary();
}
