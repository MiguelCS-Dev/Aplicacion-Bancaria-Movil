import 'package:bank_app/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:bank_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:bank_app/features/profile/presentation/widgets/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<ProfileCubit>().state;

    if (state is! ProfileLoaded) {
      return const Scaffold(body: Center(child: Text("Error cargando datos")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Editar perfil")),
      body: EditProfileForm(user: state.user),
    );
  }
}
