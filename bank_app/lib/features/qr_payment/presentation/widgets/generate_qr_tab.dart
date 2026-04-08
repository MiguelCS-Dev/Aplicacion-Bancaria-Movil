import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../domain/usecases/generate_qr_data.dart';

class GenerateQrTab extends StatefulWidget {
  const GenerateQrTab({super.key});

  @override
  State<GenerateQrTab> createState() => _GenerateQrTabState();
}

class _GenerateQrTabState extends State<GenerateQrTab> {
  String? _qrData;
  bool _isLoading = true;

  final GenerateQrData generateQrData = GenerateQrData();

  @override
  void initState() {
    super.initState();
    _generateQrCode();
  }

  Future<Map<String, dynamic>?> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    return doc.data();
  }

  Future<void> _generateQrCode() async {
    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not logged in');

      final userData = await _getUserData();
      if (userData == null) throw Exception('User data not found');

      final qrString = generateQrData(
        userId: user.uid,
        userName: userData['name'] ?? 'User',
      );

      setState(() {
        _qrData = qrString;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          ? const CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.account_circle, size: 80),
                const SizedBox(height: 20),

                // Nombre usuario
                FutureBuilder<Map<String, dynamic>?>(
                  future: _getUserData(),
                  builder: (context, snapshot) {
                    final name = snapshot.data?['name'] ?? 'User';
                    return Text(name, style: const TextStyle(fontSize: 24));
                  },
                ),

                const SizedBox(height: 20),

                // QR
                if (_qrData != null) QrImageView(data: _qrData!, size: 250),

                const SizedBox(height: 20),

                const Text('Show this QR to receive payment'),
              ],
            ),
    );
  }
}
