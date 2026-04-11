import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bank_app/core/themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TransactionReceipt? receipt;
  final String? transactionId;

  TransactionReceiptPage({super.key, this.receipt, this.transactionId});

  final GlobalKey repaintKey = GlobalKey();

  Future<Uint8List> _captureImage() async {
    final boundary =
        repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  Future<TransactionReceipt> _loadReceipt() async {
    final doc = await FirebaseFirestore.instance
        .collection('transactions')
        .doc(transactionId)
        .get();

    final data = doc.data()!;

    return TransactionReceipt(
      id: doc.id,
      type: data['type'],
      description: data['description'],
      category: data['category'],
      amount: (data['amount'] as num).toDouble(),
      date: (data['timestamp'] as Timestamp?)?.toDate(),
      note: data['note'],
      recipient: data['recipient'],
      sender: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReceiptBloc(
        ShareReceipt(ReceiptRepositoryImpl(ReceiptShareService())),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text(
            "Transaction Receipt",
            style: TextStyle(color: white),
          ),
          backgroundColor: primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder<TransactionReceipt>(
          future: receipt != null ? Future.value(receipt) : _loadReceipt(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final receiptData = snapshot.data!;

            return BlocConsumer<ReceiptBloc, ReceiptState>(
              listener: (context, state) {
                if (state is ReceiptError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                final isLoading = state is ReceiptLoading;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      RepaintBoundary(
                        key: repaintKey,
                        child: ReceiptCard(receipt: receiptData),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    final bytes = await _captureImage();

                                    context.read<ReceiptBloc>().add(
                                      ShareReceiptEvent(
                                        bytes: bytes,
                                        receipt: receiptData, // 👈 importante
                                      ),
                                    );
                                  },
                            icon: isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.share, color: Colors.white),
                            label: Text(
                              isLoading ? 'Preparing...' : 'Share Receipt',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
