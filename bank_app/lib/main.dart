import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto'
      ),
      home: const MyHomePage(),
    );
  }
}

const Color primary = Color(0xFF10B981);
const Color secondary = Color(0xFF34D399);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectindex = 0;

  void onItemTapped(int index){
    setState(() {
      selectindex = index;
    });
    print('Navegation item tapped: $index');
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

      body: const _HomePageContent(),

      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


    );
  }
  
  Widget _buildBottomNavigationBar(){
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: Offset(0,-2)
          )
        ]
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: Colors.white,
        elevation: 0,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', 0),
              _buildNavItem(Icons.wallet, 'Account', 1),
              const SizedBox(width: 40),
              _buildNavItem(Icons.folder, 'Apply', 3),
              _buildNavItem(Icons.more_horiz, 'More', 4),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildNavItem(IconData icon, String label, int index){
    final isSelected = selectindex == index;
    final Color = isSelected ? primary : Colors.grey;

    return InkWell(
      onTap: () => onItemTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Color, size: 24),
            const SizedBox(height: 4),
            Text(
              label, 
              style: TextStyle(
                color: Color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            )
          ],
        ),
        ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors:[primary, secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        ),
        boxShadow: [
          BoxShadow(
            color: secondary,
            blurRadius: 10,
            offset: const Offset(0, 4)
          )
        ]

      ),
      child: FloatingActionButton(
        onPressed: () => onItemTapped(2),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(
          Icons.qr_code_scanner,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}


class _HomePageContent extends StatelessWidget{
  const _HomePageContent ();


  @override
  Widget build(BuildContext context) {

    return const SingleChildScrollView(
      child: Column(
        children: [
          
        ],
      ),
    ) ;
  }
}

