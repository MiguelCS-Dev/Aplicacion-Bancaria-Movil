import 'dart:typed_data';

import '../../domain/repositories/receipt_repository.dart';
import '../services/receipt_share_service.dart';

class ReceiptRepositoryImpl implements ReceiptRepository {
  final ReceiptShareService service;

  ReceiptRepositoryImpl(this.service);

  @override
  Future<void> shareReceipt({
    required Uint8List bytes,
    required String fileName,
    required String description,
  }) async {
    await service.share(
      bytes: bytes,
      fileName: fileName,
      description: description,
    );
  }
}
