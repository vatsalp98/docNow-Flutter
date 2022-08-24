// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:docnow/widgets/dailyActiveHourRow.dart';
import 'package:flutter/material.dart';
import 'package:week_of_year/week_of_year.dart';

import '../bloc/schedule_bloc/schedule_bloc.dart';
import '../repositories/data_repo.dart';

class ActiveHourScreen extends StatefulWidget {
  ActiveHourScreen(
      {Key? key,
      required this.weekNumber,
      required this.user_id,
      required this.scheduleBloc})
      : super(key: key);

  final String user_id;
  Bloc scheduleBloc;
  int weekNumber;
  @override
  State<ActiveHourScreen> createState() => _ActiveHourScreenState();
}

class _ActiveHourScreenState extends State<ActiveHourScreen> {
  TextEditingController weekNumberController = TextEditingController();

  var scheduleData = {};

  @override
  void initState() {
    super.initState();
    weekNumberController.text = widget.weekNumber.toString();
    Future.delayed(
      const Duration(seconds: 0),
      () async {
        var response = await DataRepo.fetchActiveHours(widget.weekNumber);
        scheduleData =
            json.decode(response['listActiveHours']['items'][0]['schedule']);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    weekNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Active Hours'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blue,
        ),
        body: BlocBuilder<ScheduleBloc, ScheduleState>(
          bloc: BlocProvider.of(context),
          builder: (context, state) {
            if (state is ScheduleInitial) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Set your Active Hours for the current week Bookings',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Week # ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            height: 25,
                            child: TextField(
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              keyboardType: TextInputType.number,
                              controller: weekNumberController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.blue[100],
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              widget.scheduleBloc
                                  .add(UserRefreshScheduleEvent());
                            },
                            icon: Icon(
                              Icons.refresh_rounded,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // MAking Schedule ROWs
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.blue[700],
                            ),
                          ),
                          onPressed: () async {},
                          child: Text('Save'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ScheduleLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ScheduleCancel) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else
              return Container();
          },
        ),
      ),
    );
  }
}
