import 'package:flutter/material.dart';

class TransactionFilter extends StatelessWidget {
  final Function(String) onFilterChanged;

  const TransactionFilter({super.key, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _button('All', 'all'),
        _button('Sent', 'debit'),
        _button('Received', 'credit'),
      ],
    );
  }

  Widget _button(String text, String value) {
    return Expanded(
      child: TextButton(
        onPressed: () => onFilterChanged(value),
        child: Text(text),
      ),
    );
  }
}
