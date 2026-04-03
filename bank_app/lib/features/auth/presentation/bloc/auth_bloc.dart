import 'package:bank_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:bank_app/features/auth/domain/usecases/logout_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/usecases/reset_password.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final ResetPassword resetPassword;
  final GetCurrentUser getCurrentUser;
  final LogoutUser logoutUser;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.getCurrentUser,
    required this.resetPassword,
    required this.logoutUser,
  }) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await loginUser(event.email, event.password);
        emit(AuthSuccess());
      } on FirebaseAuthException catch (e) {
        String errorMessage;

        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found with this email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is invalid.';
            break;
          default:
            errorMessage = e.message ?? 'Login failed';
        }

        emit(AuthError(errorMessage));
      } catch (e) {
        emit(AuthError('An unexpected error occurred'));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await registerUser(event.email, event.password, event.name);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<CheckAuthStatusEvent>((event, emit) {
     final isLoggedIn = getCurrentUser();
      if (isLoggedIn) {
        emit(AuthSuccess());
      } else {
        emit(AuthInitial());
      }
    });
    on<ResetPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await resetPassword(event.email);
        emit(PasswordResetSuccess());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<LogoutEvent>((event, emit) async {
      await logoutUser();
      emit(AuthInitial());
    });
  }
}