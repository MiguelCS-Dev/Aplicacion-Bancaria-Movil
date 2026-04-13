import 'package:bank_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class SecuritySetts extends StatelessWidget {
  const SecuritySetts({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildHeader(),
          const SizedBox(height: 30),
          _buildContent(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

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
          child: const Icon(Icons.security, size: 40, color: primary),
        ),
        const SizedBox(height: 15),
        const Text(
          'Security Settings',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
        children: [
          _item(
            icon: Icons.lock_outline,
            title: 'Change Password',
            subtitle:
                'Update your current password to keep your account secure',
          ),
          _divider(),
          _item(
            icon: Icons.pin_outlined,
            title: 'PIN Security',
            subtitle: 'Use a PIN for quick and secure access',
            hasSwitch: true,
          ),
          _divider(),
          _item(
            icon: Icons.verified_user_outlined,
            title: 'Two-Factor Authentication',
            subtitle: 'Add an extra layer of security',
            hasSwitch: true,
          ),
          _divider(),
          _item(
            icon: Icons.fingerprint,
            title: 'Biometric Authentication',
            subtitle: 'Use fingerprint or face ID',
            hasSwitch: true,
          ),
          _divider(),
          _item(
            icon: Icons.quiz_outlined,
            title: 'Security Questions',
            subtitle: 'Set recovery questions',
            hasSwitch: true,
          ),
          _divider(),
          _item(
            icon: Icons.history,
            title: 'Login History',
            subtitle: 'Review account access activity',
          ),
        ],
      ),
    );
  }

  Widget _item({
    required IconData icon,
    required String title,
    required String subtitle,
    bool hasSwitch = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primary),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13.5, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          if (hasSwitch)
            const Switch(value: false, onChanged: null)
          else
            const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(color: Colors.grey[200], height: 1),
    );
  }
}
