import 'package:bank_app/core/routes/go_router_refresh.dart';
import 'package:bank_app/features/account/presentation/pages/account_page.dart';
import 'package:bank_app/features/profile/data/datasources/firebase_profile_datasource.dart';
import 'package:bank_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:bank_app/features/profile/domain/usecases/get_user_profile.dart';
import 'package:bank_app/features/profile/domain/usecases/update_user_profile.dart';
import 'package:bank_app/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:bank_app/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:bank_app/features/profile/presentation/pages/profile_page.dart';
import 'package:bank_app/features/settings/presentation/pages/general_page.dart';
import 'package:bank_app/features/settings/presentation/pages/more_page.dart';
import 'package:bank_app/features/settings/presentation/pages/security_page.dart';
import 'package:bank_app/features/transaction/data/datasources/firebase_transaction_database.dart';
import 'package:bank_app/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:bank_app/features/transaction/domain/usecases/get_transaction.dart';
import 'package:bank_app/features/transaction/presentation/bloc/transaction_cubit.dart';
import 'package:bank_app/features/transaction/presentation/pages/transaction_page.dart';
import 'package:bank_app/features/transaction_receipt/domain/entities/transaction_receipt.dart';
import 'package:bank_app/features/transaction_receipt/presentation/pages/transaction_receipt_page.dart';
import 'package:bank_app/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:bank_app/features/transfer/presentation/pages/transfer_page.dart';
import 'package:bank_app/features/transfer/transfer_injection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'package:bank_app/features/qr_payment/presentation/pages/qr_payment_page.dart';

class AppRouter {
  static GoRouter createRouter(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return GoRouter(
      initialLocation: '/',
      refreshListenable: GoRouterRefreshStream(authBloc.stream),

      redirect: (context, state) {
        final authState = authBloc.state;

        final isLoggedIn = authState is AuthSuccess;
        final isLoggingIn = state.matchedLocation == '/';

        if (!isLoggedIn && !isLoggingIn) {
          return '/';
        }

        if (isLoggedIn && isLoggingIn) {
          return '/home';
        }

        return null;
      },

      routes: [
        GoRoute(path: '/', builder: (context, state) => const AuthScreen()),
        GoRoute(path: '/home', builder: (context, state) => const MyHomePage()),
        GoRoute(
          path: '/qr-payment',
          builder: (context, state) => const QrPaymentPage(),
        ),
        GoRoute(
          path: '/transactions',
          builder: (context, state) {
            return BlocProvider(
              create: (_) => TransactionCubit(
                GetTransactions(
                  TransactionRepositoryImpl(
                    FirebaseTransactionDataSource(FirebaseFirestore.instance),
                  ),
                ),
              )..loadTransactions(FirebaseAuth.instance.currentUser!.uid),

              child: const TransactionPage(),
            );
          },
        ),
        GoRoute(
          path: '/receipt',
          name: 'receipt',
          builder: (context, state) {
            final extra = state.extra;

            if (extra is String) {
              return TransactionReceiptPage(transactionId: extra);
            }

            return TransactionReceiptPage(receipt: extra as TransactionReceipt);
          },
        ),
        GoRoute(
          path: '/account',
          name: 'account',
          builder: (context, state) => const AccountPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) {
            final firestore = FirebaseFirestore.instance;
            final auth = FirebaseAuth.instance;

            final dataSource = FirebaseProfileDataSource(firestore, auth);
            final repository = ProfileRepositoryImpl(dataSource);

            return BlocProvider(
              create: (_) => ProfileCubit(
                GetUserProfile(repository),
                UpdateUserProfile(repository),
              )..loadProfile(),
              child: const ProfilePage(),
            );
          },
        ),
        GoRoute(
          path: '/edit-profile',
          builder: (context, state) {
            final cubit = state.extra as ProfileCubit;

            return BlocProvider.value(
              value: cubit,
              child: const EditProfilePage(),
            );
          },
        ),
        GoRoute(
          path: '/transfer',
          builder: (context, state) {
            return BlocProvider(
              create: (_) => TransferCubit(
                getUserByAccount: TransferInjection.getUserByAccount,
                makeTransfer: TransferInjection.makeTransfer,
                getCurrentUser: TransferInjection.getCurrentUser,
              ),
              child: TransferPage(),
            );
          },
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const MorePage(),
        ),
        GoRoute(
          path: '/settings/security',
          builder: (_, _) => const SecurityPage(),
        ),
        GoRoute(
          path: '/settings/general',
          builder: (_, _) => const GeneralPage(),
        ),
      ],
    );
  }
}
