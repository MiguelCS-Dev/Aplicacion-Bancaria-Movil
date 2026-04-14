import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
  final String initial;

  const LanguagePage({super.key, required this.initial});

  @override
  Widget build(BuildContext context) {
    final languages = [
      {'code': 'en', 'label': 'English'},
      {'code': 'es', 'label': 'Español'},
      {'code': 'fr', 'label': 'Français'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Language')),
      body: ListView(
        children: languages.map((lang) {
          final isSelected = initial == lang['code'];

          return ListTile(
            title: Text(lang['label']!),
            trailing: isSelected
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              Navigator.pop(context, lang['code']);
            },
          );
        }).toList(),
      ),
    );
  }
}
