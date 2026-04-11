import 'package:bank_app/core/themes/app_colors.dart';
import 'package:bank_app/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:bank_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:bank_app/features/profile/presentation/widgets/edit_header.dart';
import 'package:bank_app/features/profile/presentation/widgets/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          Navigator.pop(context);
        }
        if (state is ProfileError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is! ProfileLoaded) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
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
                child: SingleChildScrollView(
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
                            EditHeader(),
                            const SizedBox(height: 30),

                            EditProfileForm(user: state.user),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
