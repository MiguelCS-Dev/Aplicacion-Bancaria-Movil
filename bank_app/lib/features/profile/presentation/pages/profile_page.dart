import 'package:bank_app/core/themes/app_colors.dart';
import 'package:bank_app/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:bank_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:bank_app/features/profile/presentation/widgets/profile_card.dart';
import 'package:bank_app/features/profile/presentation/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [secondary, primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              if (state is ProfileLoaded) {
                final user = state.user;

                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                            ),
                            ProfileHeader(fullName: user.name),
                            const SizedBox(height: 30),
                            ProfileCard(user: user),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const Center(child: Text("Error"));
            },
          ),
        ),
      ),
    );
  }
}
