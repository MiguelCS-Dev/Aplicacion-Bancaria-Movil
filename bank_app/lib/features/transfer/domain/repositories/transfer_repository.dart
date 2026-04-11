import '../entities/user_account.dart';
import '../entities/transfer.dart';

abstract class TransferRepository {
  Future<UserAccount> getUserByAccount(String accountNumber);

  Future<String> makeTransfer(Transfer transfer);
}
