import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/make_qr_payment.dart';
import 'qr_payment_state.dart';

class QrPaymentCubit extends Cubit<QrPaymentState> {
  final MakeQrPayment makeQrPayment;

  QrPaymentCubit(this.makeQrPayment) : super(QrPaymentInitial());

  Future<void> makePayment({
    required String senderId,
    required String receiverId,
    required double amount,
    required String receiverName,
    required String note,
  }) async {
    emit(QrPaymentLoading());

    try {
      await makeQrPayment(
        senderId: senderId,
        receiverId: receiverId,
        amount: amount,
        receiverName: receiverName,
        note: note,
      );

      emit(QrPaymentSuccess());
    } catch (e) {
      emit(QrPaymentError(e.toString()));
    }
  }
}
