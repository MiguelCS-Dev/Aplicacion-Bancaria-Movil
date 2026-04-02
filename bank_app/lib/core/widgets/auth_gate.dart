import 'package:bank_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bank_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:bank_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:bank_app/features/auth/presentation/pages/auth_page.dart';
import 'package:bank_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();

    // Revisar sesión al iniciar
    context.read<AuthBloc>().add(CheckAuthStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthSuccess) {
          return const MyHomePage();
        }

        return const AuthScreen();
      },
    );
  }
}