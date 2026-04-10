import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountNumberTile extends StatelessWidget {
  final String accountNumber;

  const AccountNumberTile({super.key, required this.accountNumber});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Número de cuenta"),
      subtitle: Text(accountNumber),
      trailing: IconButton(
        icon: const Icon(Icons.copy),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: accountNumber));

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Número copiado")));
        },
      ),
    );
  }
}
