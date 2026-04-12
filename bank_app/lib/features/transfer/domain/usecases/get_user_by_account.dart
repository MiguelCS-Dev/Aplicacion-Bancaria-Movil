import '../entities/user_account.dart';
import '../repositories/transfer_repository.dart';

class GetUserByAccount {
  final TransferRepository repository;

  GetUserByAccount(this.repository);

  Future<UserAccount> call(String accountNumber) async {
    if (accountNumber.isEmpty) {
      throw Exception('Account number cannot be empty');
    }

    return await repository.getUserByAccount(accountNumber);
  }
}
