import 'dart:typed_data';

import '../repositories/receipt_repository.dart';

class ShareReceipt {
  final ReceiptRepository repository;

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
