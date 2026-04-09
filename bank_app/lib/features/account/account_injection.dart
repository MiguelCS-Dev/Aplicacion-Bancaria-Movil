import 'package:bank_app/features/account/domain/usecases/get_account_summary.dart';
import 'package:bank_app/features/account/domain/usecases/get_user.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'data/datasources/firebase_user_datasource.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'presentation/bloc/account_bloc.dart';

final slAccount = GetIt.instance;

void initAccount() {
  if (slAccount.isRegistered<GetAccountSummary>()) return;

  // BLoC
  slAccount.registerFactory(
    () => AccountBloc(getUserData: slAccount(), getAccountSummary: slAccount()),
  );

  // UseCases
  slAccount.registerLazySingleton(() => GetUserData(slAccount()));
  slAccount.registerLazySingleton(() => GetAccountSummary(slAccount()));

  // Repository
  slAccount.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(slAccount()),
  );

  // DataSource
  slAccount.registerLazySingleton(
    () => FirebaseUserDataSource(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
    ),
  );
}
