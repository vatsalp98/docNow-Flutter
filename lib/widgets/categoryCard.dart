import 'package:flutter/material.dart';

Widget categoryCard(String title, String assetPath) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4, right: 4),
              child: Image.asset(
                assetPath,
                width: 75,
                height: 75,
              ),
            ),
            title.length < 9
                ? Text(
                    '$title',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  )
                : Text(
                    title.substring(0, 8) + '...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
          ],
        ),
      ),
    ),
  );
}
