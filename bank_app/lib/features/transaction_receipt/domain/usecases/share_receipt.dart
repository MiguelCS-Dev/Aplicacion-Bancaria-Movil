import 'dart:typed_data';
import 'package:bank_app/features/transaction_receipt/data/repositories/receipt_repository_impl.dart';

class ShareReceipt {
  final ReceiptRepositoryImpl repository;

  ShareReceipt(this.repository);

  Future<void> call({
    required Uint8List bytes,
    required String fileName,
    required String description,
  }) async {
    await repository.shareReceipt(
      bytes: bytes,
      fileName: fileName,
      description: description,
    );
  }
}
