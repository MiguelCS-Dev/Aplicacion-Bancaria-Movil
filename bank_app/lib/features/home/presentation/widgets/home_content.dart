import 'package:flutter/material.dart';
import 'package:bank_app/features/home/presentation/widgets/header_content.dart';
import 'package:bank_app/features/home/presentation/widgets/bank_card.dart';
import 'package:bank_app/features/home/presentation/widgets/action_grid.dart';
import 'package:bank_app/features/home/presentation/widgets/transaction_section.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          HeaderSection(),
          BankCardWidget(),
          ActionGridSection(),
          TransactionHistorySection(),
        ],
      ),
    );
  }
}