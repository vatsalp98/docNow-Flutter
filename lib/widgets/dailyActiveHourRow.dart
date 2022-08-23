import 'package:flutter/material.dart';

Widget dailyActiveHourRow(String day, TextEditingController controller,
    TextEditingController controller2) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '$day: ',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          width: 50,
          height: 30,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: controller,
          ),
        ),
        Text(
          ' am to ',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          width: 50,
          height: 30,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: controller2,
          ),
        ),
        Text(
          ' pm',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
