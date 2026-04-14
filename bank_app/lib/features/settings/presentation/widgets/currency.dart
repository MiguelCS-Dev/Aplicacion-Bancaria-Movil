import 'package:flutter/material.dart';

class CurrencyPage extends StatelessWidget {
  final String initial;

  const CurrencyPage({super.key, required this.initial});

  @override
  Widget build(BuildContext context) {
    final currencies = [
      {'code': 'USD', 'label': 'US Dollar'},
      {'code': 'EUR', 'label': 'Euro'},
      {'code': 'COP', 'label': 'Colombian Peso'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Currency')),
      body: ListView(
        children: currencies.map((currency) {
          final isSelected = initial == currency['code'];

          return ListTile(
            title: Text(currency['label']!),
            subtitle: Text(currency['code']!),
            trailing: isSelected
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              Navigator.pop(context, currency['code']);
            },
          );
        }).toList(),
      ),
    );
  }
}
