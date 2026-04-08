import 'package:bank_app/features/qr_payment/domain/repositories/qr_payment_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/qr_payment/data/datasources/qr_remote_datasource.dart';
import '../../features/qr_payment/data/repositories/qr_payment_repository_impl.dart';
import '../../features/qr_payment/domain/usecases/make_qr_payment.dart';
import '../../features/qr_payment/presentation/bloc/qr_payment_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // DataSources
  sl.registerLazySingleton<QrPaymentRemoteDataSource>(
    () => QrPaymentRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<QrPaymentRepository>(
    () => QrPaymentRepositoryImpl(sl()),
  );

  // UseCase
  sl.registerLazySingleton(() => MakeQrPayment(sl()));

  // Cubit
  sl.registerFactory(() => QrPaymentCubit(sl()));
}
