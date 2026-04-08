abstract class QrPaymentState {}

class QrPaymentInitial extends QrPaymentState {}

class QrPaymentLoading extends QrPaymentState {}

class QrPaymentSuccess extends QrPaymentState {}

class QrPaymentError extends QrPaymentState {
  final String message;

  QrPaymentError(this.message);
}
