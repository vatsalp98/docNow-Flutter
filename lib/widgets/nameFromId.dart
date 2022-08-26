import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../repositories/data_repo.dart';

Widget nameFromId(BuildContext context, String id) {
  return FutureBuilder(
    future: DataRepo.fetchDoctorInfo(id),
    builder: ((context, snapshot) {
      if (snapshot.hasData &&
          snapshot.connectionState == ConnectionState.done) {
        var data = snapshot.data as Map;
        return Text(
          'Dr. ' + data['full_name'],
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        );
      } else
        return Center(child: CircularProgressIndicator());
    }),
  );
}
