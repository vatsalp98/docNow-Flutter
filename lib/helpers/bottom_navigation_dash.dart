import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;
  final screens = const [
    MyHomePage(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   foregroundColor: Colors.transparent,
        // ),
        body: Center(
          child: IndexedStack(
            children: screens,
            index: currentIndex,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              label: "Settings",
            )
          ],
          backgroundColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          iconSize: 25,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 18,
          unselectedFontSize: 14,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {},
          child: const Icon(
            Icons.search,
            size: 30,
          ),
        ),
      ),
    );
  }
}
