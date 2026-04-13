import 'package:bank_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class GeneralSetts extends StatelessWidget {
  const GeneralSetts({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildHeader(),
          const SizedBox(height: 30),

          _buildSection(
            title: 'Preferences',
            children: [
              _buildItem(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                subtitle: 'Enable dark theme',
                hasSwitch: true,
              ),
              _divider(),
              _buildItem(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'Select your preferred language',
                onTap: () {},
              ),
              _divider(),
              _buildItem(
                icon: Icons.attach_money,
                title: 'Currency',
                subtitle: 'Choose your default currency',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// 🔔 NOTIFICATIONS
          _buildSection(
            title: 'Notifications',
            children: [
              _buildItem(
                icon: Icons.notifications_outlined,
                title: 'Push Notifications',
                subtitle: 'Receive notifications from the app',
                hasSwitch: true,
              ),
              _divider(),
              _buildItem(
                icon: Icons.receipt_long,
                title: 'Transaction Alerts',
                subtitle: 'Get notified for every transaction',
                hasSwitch: true,
              ),
              _divider(),
              _buildItem(
                icon: Icons.campaign_outlined,
                title: 'Promotions',
                subtitle: 'Receive offers and promotions',
                hasSwitch: true,
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// 🆘 SUPPORT
          _buildSection(
            title: 'Support',
            children: [
              _buildItem(
                icon: Icons.help_outline,
                title: 'Help Center',
                subtitle: 'Find answers to common questions',
                onTap: () {},
              ),
              _divider(),
              _buildItem(
                icon: Icons.support_agent,
                title: 'Contact Support',
                subtitle: 'Get help from our support team',
                onTap: () {},
              ),
              _divider(),
              _buildItem(
                icon: Icons.question_answer_outlined,
                title: 'FAQs',
                subtitle: 'Frequently asked questions',
                onTap: () {},
              ),
              _divider(),
              _buildItem(
                icon: Icons.bug_report_outlined,
                title: 'Report a Problem',
                subtitle: 'Let us know if something is wrong',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// 👤 ACCOUNT
          _buildSection(
            title: 'Account',
            children: [
              _buildItem(
                icon: Icons.logout,
                title: 'Logout',
                subtitle: 'Sign out from your account',
                onTap: () {},
                isDestructive: true,
              ),
              _divider(),
              _buildItem(
                icon: Icons.delete_outline,
                title: 'Delete Account',
                subtitle: 'Permanently remove your account',
                onTap: () {},
                isDestructive: true,
              ),
              _divider(),
              _buildItem(
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
                subtitle: 'Read our terms and conditions',
                onTap: () {},
              ),
              _divider(),
              _buildItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                subtitle: 'Learn how we handle your data',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  /// 🔹 HEADER
  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.settings, size: 40, color: primary),
        ),
        const SizedBox(height: 15),
        const Text(
          'General Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  /// 🔹 SECTION CONTAINER
  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),

          ...children,
        ],
      ),
    );
  }

  /// 🔹 ITEM
  Widget _buildItem({
    required IconData icon,
    required String title,
    required String subtitle,
    bool hasSwitch = false,
    bool switchValue = false,
    Function(bool)? onSwitchChanged,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive ? Colors.red : primary;

    return InkWell(
      onTap: hasSwitch ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            /// ICON
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 22),
            ),

            const SizedBox(width: 15),

            /// TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? Colors.red : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            /// TRAILING
            if (hasSwitch)
              Switch(
                value: switchValue,
                onChanged: onSwitchChanged,
                activeTrackColor: primary,
              )
            else
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(height: 1, color: Colors.grey[200]),
    );
  }
}
