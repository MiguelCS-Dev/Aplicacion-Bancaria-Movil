import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ReceiptShareService {
  Future<void> share({
    required Uint8List bytes,
    required String fileName,
    required String description,
  }) async {
    if (kIsWeb) {
      await Share.shareXFiles([
        XFile.fromData(bytes, name: fileName, mimeType: 'image/png'),
      ], text: description);
    } else {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$fileName');

      await file.writeAsBytes(bytes);

      await Share.shareXFiles([XFile(file.path)], text: description);
    }
  }
}
