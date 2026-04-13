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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [primary, secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 10),
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
        Text("Balance", style: TextStyle(color: secondaryWhite, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          balance,
          style: const TextStyle(
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

  String mask(String number) {
    if (number.length <= 4) return number;
    final last4 = number.substring(number.length - 4);
    return "**** **** **** $last4";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      mask(cardNumber),
      style: const TextStyle(
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
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Card Holder',
              style: TextStyle(color: secondaryWhite, fontSize: 12),
            ),
            Text(
              cardHolder,
              style: const TextStyle(color: white, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Expires',
              style: TextStyle(color: secondaryWhite, fontSize: 12),
            ),
            Text(
              expiryDate,
              style: const TextStyle(color: white, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
