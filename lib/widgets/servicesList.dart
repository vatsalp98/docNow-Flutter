import 'package:flutter/material.dart';

Widget servicesList(List services, int length) {
  return RichText(
    text: TextSpan(
      children: [
        for (var i = 0; i < length - 1; i++)
          TextSpan(
            text: services[i] + ' & ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        TextSpan(
          text: services[length - 1],
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
