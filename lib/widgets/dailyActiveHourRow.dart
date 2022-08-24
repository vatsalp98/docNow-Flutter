import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

Widget dailyActiveHourRow(BuildContext context, String day,
    TextEditingController controller, TextEditingController controller2) {
  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      String pickedTime = "";
      return Padding(
        padding: const EdgeInsets.all(7.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '$day: ',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                TimeRange range = await showTimeRangePicker(
                  context: context,
                  use24HourFormat: true,
                  ticks: 12,
                  ticksWidth: 2,
                  labels: [
                    "00:00",
                    "03:00",
                    "06:00",
                    "09:00",
                    "12:00",
                    "15:00",
                    "18:00",
                    "21:00"
                  ].asMap().entries.map((e) {
                    return ClockLabel.fromIndex(
                        idx: e.key, length: 8, text: e.value);
                  }).toList(),
                  start: const TimeOfDay(hour: 9, minute: 0),
                  end: const TimeOfDay(hour: 18, minute: 0),
                );
                pickedTime = range.startTime.format(context) +
                    range.endTime.format(context);
                setState;
              },
            ),
            Text('$pickedTime'),

            // SizedBox(
            //   width: 50,
            //   height: 25,
            //   child: TextField(
            //     textAlign: TextAlign.center,
            //     style: const TextStyle(
            //       color: Colors.black,
            //       fontSize: 16,
            //       fontWeight: FontWeight.w700,
            //     ),
            //     keyboardType: TextInputType.number,
            //     controller: controller,
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(5),
            //         borderSide: BorderSide.none,
            //       ),
            //       filled: true,
            //       fillColor: Colors.blue[100],
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(5),
            //         borderSide: const BorderSide(
            //           color: Colors.blue,
            //           width: 2.0,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const Text(
            //   ' am to ',
            //   style: TextStyle(
            //     fontSize: 15,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // SizedBox(
            //   width: 50,
            //   height: 30,
            //   child: TextField(
            //     textAlign: TextAlign.center,
            //     style: const TextStyle(
            //       color: Colors.black,
            //       fontSize: 16,
            //       fontWeight: FontWeight.w700,
            //     ),
            //     keyboardType: TextInputType.number,
            //     controller: controller2,
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(5),
            //         borderSide: BorderSide.none,
            //       ),
            //       filled: true,
            //       fillColor: Colors.blue[100],
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(5),
            //         borderSide: const BorderSide(
            //           color: Colors.blue,
            //           width: 2.0,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const Text(
            //   ' pm',
            //   style: TextStyle(
            //     fontSize: 15,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
          ],
        ),
      );
    },
  );
}
