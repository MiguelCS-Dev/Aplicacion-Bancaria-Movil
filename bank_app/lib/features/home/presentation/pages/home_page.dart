import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bank_app/features/home/presentation/widgets/home_content.dart';
import 'package:bank_app/features/home/presentation/components/bottom_navbar.dart';
import 'package:bank_app/features/home/presentation/components/fab_button.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  final user = FirebaseAuth.instance.currentUser;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    debugPrint('Navigation item tapped: $index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: HomePageContent(userName: user?.displayName ?? 'Usuario'),
      bottomNavigationBar: const BottomNavbar(),
      floatingActionButton: FabButton(
        onTap: () {
          context.push('/qr-payment');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
