import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

class AppRoutes {
  static const String qrPayment = '/qr-payment';
  static Route generateRoute(String route) {
    switch (route) {
      case '/':
        return MaterialPageRoute(builder: (_) => const AuthScreen());

      case '/home':
        return MaterialPageRoute(builder: (_) => const MyHomePage());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Ruta no encontrada'))),
        );
    }
  }
}
