import 'package:flutter/material.dart';
import 'package:bank_app/core/themes/app_colors.dart';

class BankCardWidget extends StatelessWidget {
  final String balance;
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;

  const BankCardWidget({
    super.key,
    required this.balance,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
  });

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
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _CardTop(),
          _BalanceDisplay(balance: balance),
          _CardNumber(cardNumber: cardNumber),
          _CardDetails(cardHolder: cardHolder, expiryDate: expiryDate),
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
            color: white,
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
  final String balance;

  const _BalanceDisplay({required this.balance});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(balance, style: TextStyle(color: secondaryWhite, fontSize: 12)),
        SizedBox(height: 4),
        Text(
          '\$9999',
          style: TextStyle(
            color: white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _CardNumber extends StatelessWidget {
  final String cardNumber;

  const _CardNumber({required this.cardNumber});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '**** **** **** 1234',
      style: TextStyle(
        color: white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 4,
      ),
    );
  }
}

class _CardDetails extends StatelessWidget {
  final String cardHolder;
  final String expiryDate;

  const _CardDetails({required this.cardHolder, required this.expiryDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Card Holder',
              style: TextStyle(color: secondaryWhite, fontSize: 12),
            ),
            Text(
              'User',
              style: TextStyle(color: white, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Expires',
              style: TextStyle(color: secondaryWhite, fontSize: 12),
            ),
            Text(
              '12/26',
              style: TextStyle(color: white, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
