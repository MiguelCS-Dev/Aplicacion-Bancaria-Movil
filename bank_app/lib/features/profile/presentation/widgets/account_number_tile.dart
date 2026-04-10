import 'package:bank_app/core/themes/app_colors.dart';
import 'package:bank_app/core/widgets/account_number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountNumberTile extends StatelessWidget {
  final String accountNumber;

  const AccountNumberTile({super.key, required this.accountNumber});

  String mask(String number) {
    if (number.length <= 4) {
      return number;
    }
    return "**** **** **** ${number.substring(number.length - 4)}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Bank Account", style: TextStyle(color: Colors.grey[600])),
          Row(
            children: [
              Text(
                mask(AccountNumberFormatter.format(accountNumber)),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 18),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: accountNumber));

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Copied number")),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
