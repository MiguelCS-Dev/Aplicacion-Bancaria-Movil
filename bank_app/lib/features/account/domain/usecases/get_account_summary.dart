import 'package:bank_app/features/account/domain/entities/account_summary.dart';
import 'package:bank_app/features/account/domain/repositories/user_repository.dart';

class GetAccountSummary {
  final UserRepository repository;

  GetAccountSummary(this.repository);

  Future<AccountSummaryEntity> call() async {
    return await repository.getAccountSummary();
  }
}
