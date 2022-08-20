import 'package:flutter/material.dart';

Widget homeTitle() {
  return Padding(
    padding: const EdgeInsets.all(7.0),
    child: ListTile(
      title: const Text(
        'Find Your',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          letterSpacing: 0.4,
        ),
      ),
      subtitle: const Text(
        'Specialist',
        style: TextStyle(
          color: Colors.black,
          fontSize: 19,
          letterSpacing: 0.4,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.help_rounded),
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}
