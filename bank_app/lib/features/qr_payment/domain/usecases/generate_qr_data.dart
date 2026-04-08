import 'dart:convert';

class GenerateQrData {
  String call({required String userId, required String userName}) {
    final qrPayload = {
      'userId': userId,
      'userName': userName,
      'type': 'receive_payment',
    };

    return jsonEncode(qrPayload);
  }
}
