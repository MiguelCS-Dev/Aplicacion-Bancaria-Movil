import 'package:bank_app/core/themes/app_colors.dart';
import 'package:bank_app/features/home/presentation/bloc/home_cubit.dart';
import 'package:bank_app/features/profile/data/datasources/firebase_profile_datasource.dart';
import 'package:bank_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:bank_app/features/profile/domain/usecases/get_user_profile.dart';
import 'package:bank_app/features/transaction/data/datasources/firebase_transaction_database.dart';
import 'package:bank_app/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:bank_app/features/transaction/domain/usecases/get_transaction.dart';
import 'package:bank_app/features/transaction/presentation/bloc/transaction_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bank_app/features/home/presentation/widgets/home_content.dart';
import 'package:bank_app/features/home/presentation/components/bottom_navbar.dart';
import 'package:bank_app/features/home/presentation/components/fab_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  final user = FirebaseAuth.instance.currentUser;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    debugPrint('Navigation item tapped: $index');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final firestore = FirebaseFirestore.instance;
            final dataSource = FirebaseTransactionDataSource(firestore);
            final repository = TransactionRepositoryImpl(dataSource);
            final usecase = GetTransactions(repository);

            final cubit = TransactionCubit(usecase);

            if (user != null) {
              cubit.loadTransactions(user!.uid);
            }

            return cubit;
          },
        ),

        BlocProvider(
          create: (context) {
            final firestore = FirebaseFirestore.instance;
            final auth = FirebaseAuth.instance;

            final dataSource = FirebaseProfileDataSource(firestore, auth);
            final repository = ProfileRepositoryImpl(dataSource);
            final usecase = GetUserProfile(repository);

            final cubit = HomeCubit(usecase);
            cubit.loadUser();

            return cubit;
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: HomePageContent(userName: user?.displayName ?? 'Usuario'),
        bottomNavigationBar: const BottomNavbar(),
        floatingActionButton: FabButton(
          onTap: () {
            context.push('/qr-payment');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
