import '../entities/transfer.dart';
import '../repositories/transfer_repository.dart';

class MakeTransfer {
  final TransferRepository repository;

  MakeTransfer(this.repository);

  Future<String> call(Transfer transfer) async {
    if (transfer.amount <= 0) {
      throw Exception('Amount must be greater than 0');
    }

    return await repository.makeTransfer(transfer);
  }
}
