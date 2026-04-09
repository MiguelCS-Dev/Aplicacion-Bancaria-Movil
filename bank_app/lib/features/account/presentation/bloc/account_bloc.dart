import 'package:bank_app/features/account/domain/usecases/get_account_summary.dart';
import 'package:bank_app/features/account/domain/usecases/get_user.dart';
import 'package:bank_app/features/account/presentation/bloc/account_event.dart';
import 'package:bank_app/features/account/presentation/bloc/account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetUserData getUserData;
  final GetAccountSummary getAccountSummary;

  AccountBloc({required this.getUserData, required this.getAccountSummary})
    : super(AccountInitial()) {
    on<GetUserEvent>((event, emit) async {
      emit(AccountLoading());

      try {
        final user = await getUserData();
        final summary = await getAccountSummary();

        if (user != null) {
          emit(AccountLoaded(user, summary));
        } else {
          emit(AccountError('User not found'));
        }
      } catch (e) {
        emit(AccountError(e.toString()));
      }
    });
  }
}
