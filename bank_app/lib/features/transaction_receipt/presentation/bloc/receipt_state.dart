abstract class ReceiptState {}

class ReceiptInitial extends ReceiptState {}

class ReceiptLoading extends ReceiptState {}

class ReceiptSuccess extends ReceiptState {}

class ReceiptError extends ReceiptState {
  final String message;

  ReceiptError(this.message);
}
