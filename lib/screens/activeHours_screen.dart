import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:docnow/widgets/dailyActiveHourRow.dart';
import 'package:flutter/material.dart';

import '../repositories/data_repo.dart';

class ActiveHourScreen extends StatefulWidget {
  const ActiveHourScreen({Key? key}) : super(key: key);

  @override
  State<ActiveHourScreen> createState() => _ActiveHourScreenState();
}

class _ActiveHourScreenState extends State<ActiveHourScreen> {
  TextEditingController monday = TextEditingController();
  TextEditingController tuesday = TextEditingController();
  TextEditingController wednesday = TextEditingController();
  TextEditingController thursday = TextEditingController();
  TextEditingController friday = TextEditingController();
  TextEditingController saturday = TextEditingController();
  TextEditingController sunday = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextEditingController monday = TextEditingController();
    TextEditingController monday2 = TextEditingController();
    TextEditingController tuesday = TextEditingController();
    TextEditingController tuesday2 = TextEditingController();
    TextEditingController wednesday = TextEditingController();
    TextEditingController wednesday2 = TextEditingController();
    TextEditingController thursday = TextEditingController();
    TextEditingController thursday2 = TextEditingController();
    TextEditingController friday = TextEditingController();
    TextEditingController friday2 = TextEditingController();
    TextEditingController saturday = TextEditingController();
    TextEditingController saturday2 = TextEditingController();
    TextEditingController sunday = TextEditingController();
    TextEditingController sunday2 = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Active Hours'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Set your Active Hours for Bookings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              dailyActiveHourRow('Monday', monday, monday2),
              dailyActiveHourRow('Tuesday', tuesday, tuesday2),
              dailyActiveHourRow('Wednesday', wednesday, wednesday2),
              dailyActiveHourRow('Thursday', thursday, thursday2),
              dailyActiveHourRow('Friday', friday, friday2),
              dailyActiveHourRow('Saturday', saturday, saturday2),
              dailyActiveHourRow('Sunday', sunday, sunday2),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.blue[700],
                      ),
                    ),
                    onPressed: () async {
                      final user = await Amplify.Auth.getCurrentUser();
                      final schedule = {
                        "monday": "${monday.text}-${monday2.text}",
                        "tuesday": "${tuesday.text}-${tuesday2.text}",
                        "wednesday": "${wednesday.text}-${wednesday2.text}",
                        "thursday": "${thursday.text}-${thursday2.text}",
                        "friday": "${friday.text}-${friday2.text}",
                        "saturday": "${saturday.text}-${saturday2.text}",
                        "sunday": "${sunday.text}-${sunday2.text}"
                      };
                      var result = await DataRepo.createActiveHours(
                          user.userId, json.encode(schedule));
                      if (result['createActiveHours']['id'] != null) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Schedule successfully saved!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Something went Wrong!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
