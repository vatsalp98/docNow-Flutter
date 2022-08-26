import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget DailyBookingSlotsLoaded(String title, String subtitle, String trailing) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: ListTile(
      title: Text(
        DateFormat('EEE, dd').format(DateTime.parse(title)),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Icon(
        Icons.calendar_month_rounded,
        size: 25,
        color: Colors.blue[700],
      ),
      subtitle: Text(subtitle),
      tileColor: Colors.blue[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      dense: true,
      trailing: Text(
        trailing,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue[700],
        ),
      ),
    ),
  );
}
