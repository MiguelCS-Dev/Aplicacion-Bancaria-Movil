import '../repositories/qr_payment_repository.dart';

class MakeQrPayment {
  final QrPaymentRepository repository;

  MakeQrPayment(this.repository);

  Future<void> call({
    required String senderId,
    required String receiverId,
    required double amount,
    required String receiverName,
    required String note,
  }) {
    return repository.makePayment(
      senderId: senderId,
      receiverId: receiverId,
      amount: amount,
      receiverName: receiverName,
      note: note,
    );
  }
}
