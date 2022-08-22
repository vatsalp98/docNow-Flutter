import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

Widget bookNowButton(String doctor_id, String clinic_id) {
  return ElevatedButton(
    style: ButtonStyle(
      maximumSize: MaterialStateProperty.all(Size(200, 50)),
      minimumSize: MaterialStateProperty.all(Size(200, 50)),
      backgroundColor: MaterialStateProperty.all(HexColor('#224fb1')),
    ),
    onPressed: () {},
    child: Text(
      'Book Now',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
