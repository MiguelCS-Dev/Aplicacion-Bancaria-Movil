import 'dart:typed_data';

import '../../domain/entities/transaction_receipt.dart';

abstract class ReceiptEvent {}

class ShareReceiptEvent extends ReceiptEvent {
  final Uint8List bytes; //
  final TransactionReceipt receipt;

  ShareReceiptEvent({required this.bytes, required this.receipt});
}
