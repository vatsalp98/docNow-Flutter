import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

Widget messageButton(String number) {
  return ElevatedButton(
    style: ButtonStyle(
      maximumSize: MaterialStateProperty.all(Size(120, 100)),
      backgroundColor: MaterialStateProperty.all(HexColor('#e6a66d')),
    ),
    onPressed: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.message_rounded,
          color: Colors.white,
        ),
        Text('Message'),
      ],
    ),
  );
}
