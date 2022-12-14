import 'package:docnow/bloc/booking_manager_bloc/booking_manager_bloc.dart';

import '../bloc/booking_bloc/booking_bloc.dart';
import 'package:docnow/screens/bookings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;
  final screens = [
    const MyHomePage(),
    BookingScreen(),
    const SettingsScreen(),
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
        body: BlocProvider(
          create: (context) =>
              BookingManagerBloc()..add(UserLoadsBookingManagerEvent()),
          child: Center(
            child: IndexedStack(
              index: currentIndex,
              children: screens,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_day_rounded),
              label: "Bookings",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              label: "Settings",
            )
          ],
          backgroundColor: Colors.blue[700],
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
      ),
    );
  }
}
