import 'package:bank_app/features/transaction_receipt/domain/entities/transaction_receipt.dart';

import '../models/transaction_model.dart';

extension TransactionMapper on TransactionModel {
  TransactionReceipt toReceiptEntity() {
    return TransactionReceipt(
      id: id,
      type: type,
      description: description,
      category: category,
      amount: amount,
      date: date,
      note: note,
      recipient: recipient,
      sender: sender,
    );
  }
}
