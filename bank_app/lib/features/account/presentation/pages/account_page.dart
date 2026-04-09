import 'package:bank_app/core/themes/app_colors.dart';
import 'package:bank_app/features/account/domain/entities/account_summary.dart';
import 'package:bank_app/features/account/presentation/widgets/account_balance.dart';
import 'package:bank_app/features/home/presentation/components/bottom_navbar.dart';
import 'package:bank_app/features/home/presentation/components/fab_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../account_injection.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';

import '../widgets/account_header.dart';
import '../widgets/profile_section.dart';
import '../widgets/invite_friends.dart';
import '../widgets/menu_list.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.push('/home');
        break;
      case 1:
        break;
      case 2:
        context.push('/qr_payment');
        break;
      case 3:
        break;
      case 4:
        context.push('/account');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => slAccount<AccountBloc>()..add(GetUserEvent()),
      child: Scaffold(
        backgroundColor: Colors.grey[50],

        body: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return const Center(
                child: CircularProgressIndicator(color: primary),
              );
            }

            if (state is AccountLoaded) {
              return _AccountContent(
                name: state.user.name,
                summary: state.summary,
              );
            }

            if (state is AccountError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),

        bottomNavigationBar: BottomNavbar(),

        floatingActionButton: FabButton(onTap: () => _onItemTapped(2)),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class _AccountContent extends StatelessWidget {
  final String name;
  final AccountSummaryEntity summary;

  const _AccountContent({required this.name, required this.summary});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const AccountHeader(),
          const SizedBox(height: 20),
          ProfileSection(name: name),
          const SizedBox(height: 20),
          AccountSummary(
            balance: summary.balance,
            income: summary.income,
            expenses: summary.expenses,
            transactions: summary.transactions,
          ),
          const SizedBox(height: 20),
          const InviteFriends(),
          const SizedBox(height: 20),
          const MenuList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
