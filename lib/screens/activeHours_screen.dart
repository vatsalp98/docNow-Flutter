import 'dart:convert';

import 'package:docnow/widgets/dailyActiveHourRow.dart';
import 'package:docnow/widgets/dailyBookingSlotsLoaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_of_year/week_of_year.dart';
import 'package:intl/intl.dart';
import '../bloc/schedule_bloc/schedule_bloc.dart';

class ActiveHourScreen extends StatelessWidget {
  ActiveHourScreen({Key? key}) : super(key: key);

  TextEditingController weekNumberController =
      TextEditingController(text: '34');

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
          bloc: context.read<ScheduleBloc>(),
          builder: (context, state) {
            if (state is ScheduleInitial) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10, right: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please setup the number of active slots for this week:',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Text(
                        'Week Number: ${DateTime.now().weekOfYear}  (${DateTime.now().year})',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      for (var i = 0; i < 7; i++)
                        dailyActiveHourRow(
                          context,
                          DateTime.now().add(Duration(days: i)),
                        ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<ScheduleBloc>().add(
                                  UserSaveScheduleEvent(
                                    weekNumber:
                                        int.parse(weekNumberController.text),
                                  ),
                                );
                          },
                          child: Text('Save'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ScheduleLoaded) {
              print(state.scheduleList);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      'Week of ${DateFormat('EEE. dd MMM. yyyy').format(DateTime.parse(state.scheduleList[0]["date"]))}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    for (var item in state.scheduleList)
                      DailyBookingSlotsLoaded(
                        item["date"],
                        "10:00 AM to 06:00 PM",
                        item["totalSlots"].toString(),
                      ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Update'),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ScheduleLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ScheduleSaved) {
              return AlertDialog(
                content: Column(
                  children: [
                    Icon(
                      Icons.done_rounded,
                      color: Colors.green,
                      size: 40,
                    ),
                    Text('Your Schedule has been saved!'),
                  ],
                ),
              );
            } else {
              return Center(child: Text('There was an error loading!'));
            }
          },
        ),
      ),
    );
  }
}
