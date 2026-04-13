import 'package:bank_app/features/settings/presentation/widgets/divider.dart';
import 'package:bank_app/features/settings/presentation/widgets/settings_header.dart';
import 'package:bank_app/features/settings/presentation/widgets/settings_items.dart';
import 'package:bank_app/features/settings/presentation/widgets/settings_section.dart';
import 'package:flutter/material.dart';

class SecuritySetts extends StatelessWidget {
  const SecuritySetts({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(height: 20),

          SettingsHeader(icon: Icons.security, title: 'Security Settings'),

          SizedBox(height: 30),

          SettingsSection(
            title: 'Security',
            children: [
              SettingsItem(
                icon: Icons.lock_outline,
                title: 'Change Password',
                subtitle:
                    'Update your current password to keep your account secure',
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.pin_outlined,
                title: 'PIN Security',
                subtitle: 'Use a PIN for quick and secure access',
                hasSwitch: true,
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.verified_user_outlined,
                title: 'Two-Factor Authentication',
                subtitle: 'Add an extra layer of security',
                hasSwitch: true,
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.fingerprint,
                title: 'Biometric Authentication',
                subtitle: 'Use fingerprint or face ID',
                hasSwitch: true,
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.quiz_outlined,
                title: 'Security Questions',
                subtitle: 'Set recovery questions',
                hasSwitch: true,
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.history,
                title: 'Login History',
                subtitle: 'Review account access activity',
              ),
            ],
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
