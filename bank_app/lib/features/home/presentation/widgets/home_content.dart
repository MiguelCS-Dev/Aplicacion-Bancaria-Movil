import 'package:bank_app/features/home/presentation/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:bank_app/features/home/presentation/widgets/header_content.dart';
import 'package:bank_app/features/home/presentation/widgets/bank_card.dart';
import 'package:bank_app/features/home/presentation/widgets/action_grid.dart';
import 'package:bank_app/features/home/presentation/widgets/transaction_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageContent extends StatelessWidget {
  final String userName;

  const HomePageContent({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderSection(userName: userName),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is HomeLoaded) {
                final user = state.user;

                return BankCardWidget(
                  balance: "\$${user.balance}",
                  cardNumber: user.accountNumber,
                  cardHolder: user.name,
                  expiryDate: "12/26",
                );
              }

              return const SizedBox();
            },
          ),
          ActionGridSection(),
          TransactionHistorySection(),
        ],
      ),
    );
  }
}
