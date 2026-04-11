import '../../domain/entities/transfer.dart';

class TransferModel extends Transfer {
  const TransferModel({
    required super.fromAccount,
    required super.toAccount,
    required super.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'from_account': fromAccount,
      'to_account': toAccount,
      'amount': amount,
    };
  }
}
