import 'package:flutter/material.dart';
import 'package:bank_app/core/themes/app_colors.dart';

class BankCardWidget extends StatelessWidget {
  const BankCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(20),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [primary, secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _CardTop(),
          _BalanceDisplay(),
          _CardNumber(),
          _CardDetails(),
        ],
      ),
    );
  }
}

class _CardTop extends StatelessWidget {
  const _CardTop();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.credit_card, size: 40, color: Colors.orange),
        const Text(
          'VISA',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _BalanceDisplay extends StatelessWidget {
  const _BalanceDisplay();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Balance',
            style: TextStyle(color: Colors.white70, fontSize: 12)),
        SizedBox(height: 4),
        Text('\$1,234.50',
            style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _CardNumber extends StatelessWidget {
  const _CardNumber();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '**** **** **** 1234',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 4,
      ),
    );
  }
}

class _CardDetails extends StatelessWidget {
  const _CardDetails();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Card Holder',
                style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text('User',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Expires',
                style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text('12/26',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ],
        )
      ],
    );
  }
}