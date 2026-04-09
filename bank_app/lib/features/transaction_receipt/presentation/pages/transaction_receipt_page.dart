import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/receipt_repository_impl.dart';
import '../../data/services/receipt_share_service.dart';
import '../../domain/entities/transaction_receipt.dart';
import '../../domain/usecases/share_receipt.dart';
import '../bloc/receipt_bloc.dart';
import '../bloc/receipt_event.dart';
import '../bloc/receipt_state.dart';
import '../widgets/receipt_card.dart';

class TransactionReceiptPage extends StatelessWidget {
  final TransactionReceipt receipt;

  TransactionReceiptPage({super.key, required this.receipt});

  final GlobalKey repaintKey = GlobalKey();

  Future<Uint8List> _captureImage() async {
    final boundary =
        repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReceiptBloc(
        ShareReceipt(ReceiptRepositoryImpl(ReceiptShareService())),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text("Receipt")),
        body: BlocConsumer<ReceiptBloc, ReceiptState>(
          listener: (context, state) {
            if (state is ReceiptError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final isLoading = state is ReceiptLoading;

            return Column(
              children: [
                RepaintBoundary(
                  key: repaintKey,
                  child: ReceiptCard(receipt: receipt),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          final bytes = await _captureImage();

                          context.read<ReceiptBloc>().add(
                            ShareReceiptEvent(bytes: bytes, receipt: receipt),
                          );
                        },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Share Receipt"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
