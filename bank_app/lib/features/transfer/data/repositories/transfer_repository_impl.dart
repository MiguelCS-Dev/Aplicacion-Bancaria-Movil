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
  Future<String> makeTransfer(Transfer transfer) async {
    final model = TransferModel(
      toAccount: transfer.toAccount,
      amount: transfer.amount,
      note: transfer.note,
    );

    return await remoteDataSource.makeTransfer(model);
  }
}
