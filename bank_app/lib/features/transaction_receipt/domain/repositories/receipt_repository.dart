import 'dart:typed_data';

abstract class ReceiptRepository {
  Future<void> shareReceipt({
    required Uint8List bytes,
    required String fileName,
    required String description,
  });
}
