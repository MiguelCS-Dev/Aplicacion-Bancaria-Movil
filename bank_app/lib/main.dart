import 'package:bank_app/features/account/account_injection.dart';
import 'package:bank_app/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:bank_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bank_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:bank_app/features/auth/domain/usecases/login_user.dart';
import 'package:bank_app/features/auth/domain/usecases/logout_user.dart';
import 'package:bank_app/features/auth/domain/usecases/register_user.dart';
import 'package:bank_app/features/auth/domain/usecases/reset_password.dart';
import 'package:bank_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bank_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routes/app_router.dart';
import 'core/di/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await di.init();

  initAccount();

  final dataSource = FirebaseAuthDataSource(
    FirebaseAuth.instance,
    FirebaseFirestore.instance,
  );

  final repository = AuthRepositoryImpl(dataSource);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            loginUser: LoginUser(repository),
            registerUser: RegisterUser(repository),
            resetPassword: ResetPassword(repository),
            getCurrentUser: GetCurrentUser(repository),
            logoutUser: LogoutUser(repository),
          )..add(CheckAuthStatusEvent()),
        ),
      ],
      child: Builder(
        builder: (context) {
          final router = AppRouter.createRouter(context);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
