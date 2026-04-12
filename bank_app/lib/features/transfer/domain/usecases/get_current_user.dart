import 'package:bank_app/features/transfer/domain/entities/user_account.dart';
import 'package:bank_app/features/transfer/domain/repositories/transfer_repository.dart';

class GetCurrentUser {
  final TransferRepository repository;

  GetCurrentUser(this.repository);

  Future<UserAccount> call() async {
    return await repository.getCurrentUser();
  }
}
