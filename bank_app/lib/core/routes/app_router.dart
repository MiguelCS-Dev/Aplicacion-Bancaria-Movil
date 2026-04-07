import 'package:bank_app/core/routes/go_router_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'package:bank_app/features/qr_payment/presentation/pages/qr_payment_page.dart';
import 'package:bank_app/features/qr_payment/presentation/widgets/payment_confirmation_page.dart';

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
      ],
    );
  }
}
