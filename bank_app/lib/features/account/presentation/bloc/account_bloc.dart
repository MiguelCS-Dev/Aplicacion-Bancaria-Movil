import 'package:bank_app/features/account/domain/usecases/get_user.dart';
import 'package:bank_app/features/account/presentation/bloc/account_event.dart';
import 'package:bank_app/features/account/presentation/bloc/account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetUserData getUserData;

  AccountBloc(this.getUserData) : super(AccountInitial()) {
    on<GetUserEvent>((event, emit) async {
      emit(AccountLoading());

      try {
        final user = await getUserData();

        if (user != null) {
          emit(AccountLoaded(user));
        } else {
          emit(AccountError('User not found'));
        }
      } catch (e) {
        emit(AccountError(e.toString()));
      }
    });
  }
}
