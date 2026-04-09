import 'package:bank_app/features/transaction/data/datasources/firebase_transaction_database.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final FirebaseTransactionDataSource dataSource;

  TransactionRepositoryImpl(this.dataSource);

  @override
  Future<List<Transactio>> getTransactions({
    required String userId,
    required String filter,
    bool loadMore = false,
  }) async {
    final docs = await dataSource.getTransactions(
      userId: userId,
      filter: filter,
      loadMore: loadMore,
    );

    return docs.map((doc) => TransactionModel.fromFirestore(doc)).toList();
  }
}
