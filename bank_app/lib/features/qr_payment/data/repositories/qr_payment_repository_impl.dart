import '../../domain/repositories/qr_payment_repository.dart';
import '../datasources/qr_remote_datasource.dart';

class QrPaymentRepositoryImpl implements QrPaymentRepository {
  final QrPaymentRemoteDataSource remoteDataSource;

  QrPaymentRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> makePayment({
    required String senderId,
    required String receiverId,
    required double amount,
    required String receiverName,
    required String note,
  }) async {
    return await remoteDataSource.makePayment(
      senderUserId: senderId,
      receiverUserId: receiverId,
      amount: amount,
      receiverUserName: receiverName,
      note: note,
    );
  }
}
