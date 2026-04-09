import 'package:bank_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class TransactionFilter extends StatelessWidget {
  final Function(String) onFilterChanged;

  const TransactionFilter({super.key, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            onTap: (index) {
              final values = ['all', 'debit', 'credit'];
              onFilterChanged(values[index]);
            },
            indicatorColor: white,
            indicatorWeight: 3.0,
            indicatorSize: TabBarIndicatorSize.tab,

            labelColor: white,
            unselectedLabelColor: white.withAlpha(150),
            overlayColor: WidgetStateProperty.all(white.withAlpha(25)),

            tabs: [_tab('All'), _tab('Sent'), _tab('Received')],
          ),
        ],
      ),
    );
  }

  Widget _tab(String text) {
    return Tab(
      height: 48,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
