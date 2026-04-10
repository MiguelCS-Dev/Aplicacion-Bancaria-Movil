import 'package:bank_app/features/profile/domain/entities/user.dart';
import 'package:bank_app/features/profile/presentation/widgets/account_number_tile.dart';
import 'package:bank_app/features/profile/presentation/widgets/edit_profile_button.dart';
import 'package:bank_app/features/profile/presentation/widgets/profile_info_tile.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final AppUser user;

  const ProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileInfoTile(label: "Email", value: user.email),
          const Divider(),

          ProfileInfoTile(label: "Phone number", value: user.phone),
          const Divider(),

          AccountNumberTile(accountNumber: user.accountNumber),

          const SizedBox(height: 30),

          EditProfileButton(),
        ],
      ),
    );
  }
}
