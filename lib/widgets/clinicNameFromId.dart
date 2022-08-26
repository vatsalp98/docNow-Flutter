import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../repositories/data_repo.dart';

Widget ClinicNameFromId(BuildContext context, String id) {
  return FutureBuilder(
    future: DataRepo.fetchClinicInfo(id),
    builder: ((context, snapshot) {
      if (snapshot.hasData &&
          snapshot.connectionState == ConnectionState.done) {
        var data = snapshot.data as Map;
        return Text(
          data['getClinic']['name'],
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        );
      } else
        return Center(child: CircularProgressIndicator());
    }),
  );
}
