import 'package:bank_app/features/transaction/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Stream<List<Transactio>> getTransactions({
    required String userId,
    required String filter,
  });
}
