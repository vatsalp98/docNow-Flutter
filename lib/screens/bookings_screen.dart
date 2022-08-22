import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Bookings',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.grey[50],
        ),
      ),
    );
  }
}
