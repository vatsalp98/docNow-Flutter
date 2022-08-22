import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

Widget emailButton(String email) {
  return ElevatedButton(
    style: ButtonStyle(
      maximumSize: MaterialStateProperty.all(Size(120, 100)),
      backgroundColor: MaterialStateProperty.all(HexColor('#896aee')),
    ),
    onPressed: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.email_rounded,
          color: Colors.white,
        ),
        Text('Email'),
      ],
    ),
  );
}
