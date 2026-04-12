import '../../domain/entities/transfer.dart';

class TransferModel extends Transfer {
  const TransferModel({
    required super.toAccount,
    required super.amount,
    super.note,
  });

  Map<String, dynamic> toJson() {
    return {'to_account': toAccount, 'amount': amount, 'note': note ?? ''};
  }
}
