import 'package:bank_app/features/settings/presentation/widgets/currency.dart';
import 'package:bank_app/features/settings/presentation/widgets/divider.dart';
import 'package:bank_app/features/settings/presentation/widgets/language.dart';
import 'package:bank_app/features/settings/presentation/widgets/placeholder_route.dart';
import 'package:bank_app/features/settings/presentation/widgets/settings_header.dart';
import 'package:bank_app/features/settings/presentation/widgets/settings_items.dart';
import 'package:bank_app/features/settings/presentation/widgets/settings_section.dart';
import 'package:flutter/material.dart';

class GeneralSetts extends StatefulWidget {
  const GeneralSetts({super.key});

  @override
  State<GeneralSetts> createState() => _GeneralSettsState();
}

class _GeneralSettsState extends State<GeneralSetts> {
  String language = 'en';
  String currency = 'USD';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),

          const SettingsHeader(icon: Icons.settings, title: 'General Settings'),

          const SizedBox(height: 30),

          SettingsSection(
            title: 'Preferences',
            children: [
              SettingsItem(
                icon: Icons.language,
                title: 'Language',
                subtitle: language.toUpperCase(),
                onTap: () async {
                  final result = await Navigator.push<String>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LanguagePage(initial: language),
                    ),
                  );

                  if (result != null) {
                    setState(() => language = result);
                  }
                },
              ),

              const SettingsDivider(),

              SettingsItem(
                icon: Icons.attach_money,
                title: 'Currency',
                subtitle: currency,
                onTap: () async {
                  final result = await Navigator.push<String>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CurrencyPage(initial: currency),
                    ),
                  );

                  if (result != null) {
                    setState(() => currency = result);
                  }
                },
              ),

              const SettingsDivider(),

              SettingsItem(
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
                subtitle: 'View terms and policies',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const PlaceholderPage(title: 'Terms & Conditions'),
                    ),
                  );
                },
              ),

              const SettingsDivider(),

              SettingsItem(
                icon: Icons.logout,
                title: 'Logout',
                subtitle: 'Sign out of your account',
                isDestructive: true,
                onTap: () => _showLogoutDialog(context),
              ),

              const SettingsDivider(),

              SettingsItem(
                icon: Icons.delete_outline,
                title: 'Delete Account',
                subtitle: 'Remove your account data',
                isDestructive: true,
                onTap: () => _showDeleteDialog(context),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This will remove your account data from the app.\n\nThis action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
