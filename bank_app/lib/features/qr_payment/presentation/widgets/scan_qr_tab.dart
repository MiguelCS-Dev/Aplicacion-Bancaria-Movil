import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'payment_confirmation_page.dart';

const Color primaryBlue = Color(0xFF1E3A8A);

class ScanQrTab extends StatefulWidget {
  const ScanQrTab({super.key});

  @override
  State<ScanQrTab> createState() => _ScanQrTabState();
}

class _ScanQrTabState extends State<ScanQrTab> {
  final MobileScannerController cameraController = MobileScannerController();
  bool _isProcessing = false;
  bool _scannerActive = true;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> _processQrCode(String qrData) async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    await cameraController.stop(); // DETENER SCAN

    try {
      final data = jsonDecode(qrData) as Map<String, dynamic>;

      final receiverUserId = data['userId'] as String;
      final receiverUserName = data['userName'] as String;

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) throw Exception('User not logged in');

      if (currentUser.uid == receiverUserId) {
        throw Exception('Cannot pay yourself');
      }

      if (!mounted) return;

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentConfirmationScreen(
            receiverUserId: receiverUserId,
            receiverUserName: receiverUserName,
          ),
        ),
      );

      if (result == true && mounted) {
        Navigator.pop(context, true);
      } else {
        // reactivar si no hubo pago
        await cameraController.start();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid QR: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }

      // reactivar scanner
      await cameraController.start();
    } finally {
      setState(() {
        _scannerActive = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Cámara
        if (_scannerActive)
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              if (!_scannerActive) return;

              final barcodes = capture.barcodes;

              if (barcodes.isNotEmpty) {
                final code = barcodes.first.rawValue;

                if (code != null) {
                  setState(() {
                    _scannerActive = false;
                  });

                  _processQrCode(code);
                }
              }
            },
          )
        else
          Container(color: Colors.black), // pantalla apagada
        // Overlay oscuro
        Container(
          color: Colors.black.withOpacity(0.5),
          child: Column(
            children: [
              const Spacer(),

              // Marco
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Scan QR to pay',
                style: TextStyle(color: Colors.white),
              ),

              const Spacer(),

              if (_isProcessing)
                const CircularProgressIndicator(color: Colors.white),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }
}
