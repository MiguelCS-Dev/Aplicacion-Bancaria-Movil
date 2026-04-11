import '../entities/transfer.dart';
import '../repositories/transfer_repository.dart';

class MakeTransfer {
  final TransferRepository repository;

  MakeTransfer(this.repository);

  Future<String> call(Transfer transfer) async {
    if (transfer.amount <= 0) {
      throw Exception('Amount must be greater than 0');
    }

    if (transfer.fromAccount == transfer.toAccount) {
      throw Exception('Cannot transfer to the same account');
    }

    return await repository.makeTransfer(transfer);
  }
}
