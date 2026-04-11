import 'package:bank_app/features/profile/domain/usecases/get_user_profile.dart';
import 'package:bank_app/features/profile/domain/usecases/update_user_profile.dart';
import 'package:bank_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfile getUserProfile;
  final UpdateUserProfile updateUserProfile;

  ProfileCubit(this.getUserProfile, this.updateUserProfile)
    : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());

    try {
      final user = await getUserProfile();
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile({
    required String email,
    required String phone,
  }) async {
    try {
      await updateUserProfile(email: email, phone: phone);
      emit(ProfileUpdated());
      await loadProfile(); // <-- agrega esto
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
