import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransactions {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  Stream<List<Transactio>> call({
    required String userId,
    required String filter,
  }) {
    return repository.getTransactions(userId: userId, filter: filter);
  }
}
