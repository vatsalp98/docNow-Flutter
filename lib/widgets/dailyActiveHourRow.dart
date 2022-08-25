import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:intl/intl.dart';
import '../bloc/schedule_bloc/schedule_bloc.dart';

Widget dailyActiveHourRow(BuildContext context, DateTime day) {
  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      return ListTile(
        title: Text(
          '${DateFormat('EEE, d').format(day)}: ',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          '10:00 AM to 06:00 PM',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 45,
              height: 40,
              child: TextField(
                onChanged: (value) {
                  context.read<ScheduleBloc>().add(
                        UserUpdateSlotsScheduleEvent(
                          slotNumber: int.parse(value),
                          slotDate: day.toIso8601String() + 'Z',
                        ),
                      );
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                keyboardType: TextInputType.number,
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
            Text(' # of Slots'),
          ],
        ),
      );
    },
  );
}
