import 'package:bank_app/features/profile/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bank_app/features/profile/domain/usecases/get_user_profile.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetUserProfile getUserProfile;

  HomeCubit(this.getUserProfile) : super(HomeInitial());

  Future<void> loadUser() async {
    emit(HomeLoading());

    try {
      final user = await getUserProfile();
      emit(HomeLoaded(user));
    } catch (e) {
      emit(HomeError("Error cargando usuario"));
    }
  }
}
