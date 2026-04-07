abstract class QrPaymentRepository {
  Future<void> makePayment({
    required String senderId,
    required String receiverId,
    required double amount,
    required String receiverName,
    required String note,
  });
}
