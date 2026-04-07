import 'package:flutter/material.dart';
import 'package:bank_app/features/home/presentation/widgets/header_content.dart';
import 'package:bank_app/features/home/presentation/widgets/bank_card.dart';
import 'package:bank_app/features/home/presentation/widgets/action_grid.dart';
import 'package:bank_app/features/home/presentation/widgets/transaction_section.dart';

class HomePageContent extends StatelessWidget {
  final String userName;

  const HomePageContent({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderSection(userName: userName),
          BankCardWidget(
            balance: '\$1,234.50',
            cardNumber: '**** **** **** 1234',
            cardHolder: userName,
            expiryDate: '12/26',
          ),
          ActionGridSection(),
          TransactionHistorySection(),
        ],
      ),
    );
  }
}
