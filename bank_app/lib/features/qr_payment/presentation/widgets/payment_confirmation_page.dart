import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/make_qr_payment.dart';
import '../../data/repositories/qr_payment_repository_impl.dart';
import '../../data/datasources/qr_remote_datasource.dart';
import 'package:bank_app/core/themes/app_colors.dart';
import '../../../../core/di/injection.dart';

import '../bloc/qr_payment_cubit.dart';
import '../bloc/qr_payment_state.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final String receiverUserId;
  final String receiverUserName;

  const PaymentConfirmationScreen({
    super.key,
    required this.receiverUserId,
    required this.receiverUserName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<QrPaymentCubit>(),

      child: _PaymentConfirmationView(
        receiverUserId: receiverUserId,
        receiverUserName: receiverUserName,
      ),
    );
  }
}

class _PaymentConfirmationView extends StatefulWidget {
  final String receiverUserId;
  final String receiverUserName;

  const _PaymentConfirmationView({
    required this.receiverUserId,
    required this.receiverUserName,
  });

  @override
  State<_PaymentConfirmationView> createState() =>
      _PaymentConfirmationViewState();
}

class _PaymentConfirmationViewState extends State<_PaymentConfirmationView> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  double? _senderBalance;

  @override
  void initState() {
    super.initState();
    _loadSenderBalance();
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

  void _confirmPayment() {
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

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    context.read<QrPaymentCubit>().makePayment(
      senderId: currentUser.uid,
      receiverId: widget.receiverUserId,
      amount: amount,
      receiverName: widget.receiverUserName,
      note: _noteController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QrPaymentCubit, QrPaymentState>(
      listener: (context, state) {
        if (state is QrPaymentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment successful!'),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pop(context, true);
        }

        if (state is QrPaymentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text(
            'Confirm Payment',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: primary,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Recipient
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [primary, secondary]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Pay to',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.account_circle,
                      size: 70,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.receiverUserName,
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ],
                ),
              ),

              // Amount
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Amount'),
                    ),
                    const SizedBox(height: 10),
                    if (_senderBalance != null)
                      Text('Balance: \$${_senderBalance!.toStringAsFixed(2)}'),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _noteController,
                      decoration: const InputDecoration(labelText: 'Note'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Button con Cubit
              BlocBuilder<QrPaymentCubit, QrPaymentState>(
                builder: (context, state) {
                  final isLoading = state is QrPaymentLoading;

                  return ElevatedButton(
                    onPressed: isLoading ? null : _confirmPayment,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Confirm Payment'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
