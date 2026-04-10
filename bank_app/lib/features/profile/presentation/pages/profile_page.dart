import 'package:bank_app/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:bank_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:bank_app/features/profile/presentation/widgets/account_numer_tile.dart';
import 'package:bank_app/features/profile/presentation/widgets/profile_header.dart';
import 'package:bank_app/features/profile/presentation/widgets/profile_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().loadProfile();

    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileLoaded) {
            final user = state.user;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ProfileHeader(fullName: user.name),

                ProfileInfoTile(label: "Correo", value: user.email),

                ProfileInfoTile(label: "Teléfono", value: user.phone),

                AccountNumberTile(accountNumber: user.accountNumber),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    context.push(
                      '/edit-profile',
                      extra: context.read<ProfileCubit>(),
                    );
                  },
                  child: const Text("Editar perfil"),
                ),
              ],
            );
          }

          return const Center(child: Text("Error"));
        },
      ),
    );
  }
}
