import 'package:bank_app/features/transaction_receipt/domain/usecases/share_receipt.dart';
import 'package:bank_app/features/transaction_receipt/presentation/bloc/receipt_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  final ShareReceipt shareReceipt;

  ReceiptBloc(this.shareReceipt) : super(ReceiptInitial()) {
    on<ShareReceiptEvent>(_onShare);
  }

  Future<void> _onShare(
    ShareReceiptEvent event,
    Emitter<ReceiptState> emit,
  ) async {
    emit(ReceiptLoading());

    try {
      await shareReceipt(
        bytes: event.bytes,
        fileName: 'receipt_${event.receipt.id}.png',
        description: 'Transaction - ${event.receipt.description}',
      );

      emit(ReceiptSuccess());
    } catch (e) {
      emit(ReceiptError(e.toString()));
    }
  }
}
