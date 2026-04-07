import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/usecases/make_qr_payment.dart';
import '../../data/repositories/qr_payment_repository_impl.dart';
import '../../data/datasources/qr_remote_datasource.dart';
import 'package:bank_app/core/themes/app_colors.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  final String receiverUserId;
  final String receiverUserName;

  const PaymentConfirmationScreen({
    super.key,
    required this.receiverUserId,
    required this.receiverUserName,
  });

  @override
  State<PaymentConfirmationScreen> createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  bool _isProcessing = false;
  double? _senderBalance;

  late MakeQrPayment makeQrPayment;

  @override
  void initState() {
    super.initState();
    _loadSenderBalance();

    // Inicialización manual
    final dataSource = QrPaymentRemoteDataSourceImpl(
      FirebaseFirestore.instance,
    );
    final repository = QrPaymentRepositoryImpl(dataSource);
    makeQrPayment = MakeQrPayment(repository);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadSenderBalance() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (mounted) {
      setState(() {
        _senderBalance = ((doc.data()?['account_balance'] ?? 0.0) as num)
            .toDouble();
      });
    }
  }

  Future<void> _confirmPayment() async {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter an amount')));
      return;
    }

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    if (_senderBalance != null && amount > _senderBalance!) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Insufficient balance')));
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) throw Exception('User not logged in');

      await makeQrPayment(
        senderId: currentUser.uid,
        receiverId: widget.receiverUserId,
        amount: amount,
        receiverName: widget.receiverUserName,
        note: _noteController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment successful!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Confirm Payment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primary,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Recipient Card
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [primary, secondary]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text('Pay to', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 10),
                  const Icon(
                    Icons.account_circle,
                    size: 70,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.receiverUserName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Amount
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Enter Amount', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      prefixText: '\$ ',
                      hintText: '0.00',
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_senderBalance != null)
                    Text(
                      'Available balance: \$${_senderBalance!.toStringAsFixed(2)}',
                    ),
                  const SizedBox(height: 20),
                  const Text('Note'),
                  TextField(controller: _noteController, maxLines: 2),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _confirmPayment,
                child: _isProcessing
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Confirm Payment'),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
