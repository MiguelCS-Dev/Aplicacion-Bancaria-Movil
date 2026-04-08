import 'package:bank_app/features/transaction/data/datasources/firebase_transaction_database.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final FirebaseTransactionDataSource dataSource;

  TransactionRepositoryImpl(this.dataSource);

  @override
  Stream<List<Transactio>> getTransactions({
    required String userId,
    required String filter,
  }) {
    return dataSource.getTransactions(userId: userId, filter: filter).map((
      snapshot,
    ) {
      final transactions = snapshot.docs
          .map((doc) => TransactionModel.fromFirestore(doc))
          .toList();
      transactions.sort((a, b) {
        if (a.date == null) return 1;
        if (b.date == null) return -1;
        return b.date!.compareTo(a.date!);
      });

      return transactions;
    });
  }
}
