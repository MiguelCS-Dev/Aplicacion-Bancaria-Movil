import 'package:bank_app/features/transaction/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transactio>> getTransactions({
    required String userId,
    required String filter,
    bool loadMore = false,
  });
}
