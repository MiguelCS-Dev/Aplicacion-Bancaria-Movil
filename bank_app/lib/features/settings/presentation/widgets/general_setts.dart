import 'package:bank_app/features/settings/presentation/widgets/divider.dart';
import 'package:bank_app/features/settings/presentation/widgets/settings_header.dart';
import 'package:bank_app/features/settings/presentation/widgets/settings_items.dart';
import 'package:bank_app/features/settings/presentation/widgets/settings_section.dart';
import 'package:flutter/material.dart';

class GeneralSetts extends StatelessWidget {
  const GeneralSetts({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(height: 20),

          SettingsHeader(icon: Icons.settings, title: 'General Settings'),

          SizedBox(height: 30),

          SettingsSection(
            title: 'Preferences',
            children: [
              SettingsItem(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                subtitle: 'Enable dark theme',
                hasSwitch: true,
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'Select your preferred language',
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.attach_money,
                title: 'Currency',
                subtitle: 'Choose your default currency',
              ),
            ],
          ),

          SizedBox(height: 20),

          SettingsSection(
            title: 'Notifications',
            children: [
              SettingsItem(
                icon: Icons.notifications_outlined,
                title: 'Push Notifications',
                subtitle: 'Receive notifications from the app',
                hasSwitch: true,
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.receipt_long,
                title: 'Transaction Alerts',
                subtitle: 'Get notified for every transaction',
                hasSwitch: true,
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.campaign_outlined,
                title: 'Promotions',
                subtitle: 'Receive offers and promotions',
                hasSwitch: true,
              ),
            ],
          ),

          SizedBox(height: 20),

          SettingsSection(
            title: 'Support',
            children: [
              SettingsItem(
                icon: Icons.help_outline,
                title: 'Help Center',
                subtitle: 'Find answers to common questions',
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.support_agent,
                title: 'Contact Support',
                subtitle: 'Get help from our support team',
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.question_answer_outlined,
                title: 'FAQs',
                subtitle: 'Frequently asked questions',
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.bug_report_outlined,
                title: 'Report a Problem',
                subtitle: 'Let us know if something is wrong',
              ),
            ],
          ),

          SizedBox(height: 20),

          /// 👤 ACCOUNT
          SettingsSection(
            title: 'Account',
            children: [
              SettingsItem(
                icon: Icons.logout,
                title: 'Logout',
                subtitle: 'Sign out from your account',
                isDestructive: true,
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.delete_outline,
                title: 'Delete Account',
                subtitle: 'Permanently remove your account',
                isDestructive: true,
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
                subtitle: 'Read our terms and conditions',
              ),
              SettingsDivider(),
              SettingsItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                subtitle: 'Learn how we handle your data',
              ),
            ],
          ),

          SizedBox(height: 30),
        ],
      ),
    );
  }
}
