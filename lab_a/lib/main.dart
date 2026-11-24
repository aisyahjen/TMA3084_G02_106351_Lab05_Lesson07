import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';
import 'screen4.dart';

class TabModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void selectTab(int index) {
    if (_currentIndex == index) return;

    _currentIndex = index;
    notifyListeners();
  }
}

void main() => runApp(
  ChangeNotifierProvider(create: (_) => TabModel(), child: const MyApp()),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.pink, useMaterial3: true),
      home: const BottomNavLab(),
    );
  }
}

class BottomNavLab extends StatelessWidget {
  const BottomNavLab({super.key});

  @override
  Widget build(BuildContext context) {
    const screens = [Screen1(), Screen2(), Screen3(), Screen4()];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(
        title: const Text(
          'Aisyah Navigation Bar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink.shade400,
        elevation: 2,
      ),
      body: Builder(
        builder: (context) {
          final currentIndex = context.watch<TabModel>().currentIndex;
          return screens[currentIndex];
        },
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          final currentIndex = context.watch<TabModel>().currentIndex;

          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.pink.shade600,
            unselectedItemColor: Colors.pink.shade200,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            currentIndex: currentIndex,
            onTap: (index) => context.read<TabModel>().selectTab(index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.alarm_rounded),
                label: 'Alarm',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business_rounded),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school_rounded),
                label: 'School',
              ),
            ],
          );
        },
      ),
    );
  }
}
