import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

Widget voiceCallButton(String number) {
  return ElevatedButton(
    style: ButtonStyle(
      maximumSize: MaterialStateProperty.all(Size(120, 100)),
      backgroundColor: MaterialStateProperty.all(HexColor('#69baeb')),
    ),
    onPressed: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.call_rounded,
          color: Colors.white,
        ),
        Text('Voice Call'),
      ],
    ),
  );
}
