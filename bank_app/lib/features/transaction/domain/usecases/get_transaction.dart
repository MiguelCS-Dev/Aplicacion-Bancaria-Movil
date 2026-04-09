import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransactions {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  Future<List<Transactio>> call({
    required String userId,
    required String filter,
    bool loadMore = false,
  }) {
    return repository.getTransactions(
      userId: userId,
      filter: filter,
      loadMore: loadMore,
    );
  }
}
