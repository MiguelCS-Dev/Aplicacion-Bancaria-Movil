import '../../domain/entities/user_account.dart';
import '../../domain/entities/transfer.dart';
import '../../domain/repositories/transfer_repository.dart';

import '../datasources/transfer_remote_data_source.dart';
import '../models/transfer_model.dart';

class TransferRepositoryImpl implements TransferRepository {
  final TransferRemoteDataSource remoteDataSource;

  TransferRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserAccount> getUserByAccount(String accountNumber) async {
    final result = await remoteDataSource.getUserByAccount(accountNumber);
    return result;
  }

  @override
  Future<void> makeTransfer(Transfer transfer) async {
    final model = TransferModel(
      fromAccount: transfer.fromAccount,
      toAccount: transfer.toAccount,
      amount: transfer.amount,
    );

    await remoteDataSource.makeTransfer(model);
  }
}
