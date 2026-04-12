import 'package:bank_app/features/transfer/data/datasources/transfer_remote_data_source.dart';
import 'package:bank_app/features/transfer/data/repositories/transfer_repository_impl.dart';
import 'package:bank_app/features/transfer/domain/usecases/get_current_user.dart';
import 'package:bank_app/features/transfer/domain/usecases/get_user_by_account.dart';
import 'package:bank_app/features/transfer/domain/usecases/make_transfer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransferInjection {
  static void init() {
    final firestore = FirebaseFirestore.instance;

    final remoteDataSource = TransferRemoteDataSourceImpl(firestore);

    final repository = TransferRepositoryImpl(remoteDataSource);

    getUserByAccount = GetUserByAccount(repository);
    makeTransfer = MakeTransfer(repository);
    getCurrentUser = GetCurrentUser(repository);
  }

  static late GetUserByAccount getUserByAccount;
  static late MakeTransfer makeTransfer;
  static late GetCurrentUser getCurrentUser;
}
