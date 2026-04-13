import 'package:bank_app/features/settings/presentation/widgets/general_setts.dart';
import 'package:flutter/material.dart';

class GeneralPage extends StatelessWidget {
  const GeneralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('General Settings'),
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: const GeneralSetts(),
    );
  }
}
