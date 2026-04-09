import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../widgets/generate_qr_tab.dart';
import '../widgets/scan_qr_tab.dart';

class QrPaymentPage extends StatefulWidget {
  const QrPaymentPage({super.key});

  @override
  State<QrPaymentPage> createState() => _QrPaymentPageState();
}

class _QrPaymentPageState extends State<QrPaymentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Payment'),
        backgroundColor: primary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: secondaryWhite,
          labelColor: secondaryWhite,
          unselectedLabelColor: secondary,
          tabs: const [
            Tab(icon: Icon(Icons.qr_code), text: 'My QR'),
            Tab(icon: Icon(Icons.qr_code_scanner), text: 'Scan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [GenerateQrTab(), ScanQrTab()],
      ),
    );
  }
}
