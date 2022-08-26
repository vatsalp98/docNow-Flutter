import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:docnow/bloc/booking_bloc/booking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewBookingScreen extends StatefulWidget {
  NewBookingScreen({Key? key, required this.doctorData}) : super(key: key);

  final Map doctorData;

  @override
  State<NewBookingScreen> createState() => _NewBookingScreenState();
}

class _NewBookingScreenState extends State<NewBookingScreen> {
  List bookingBools = [false, false, false, false, false, false, false];

  Map selectedBooking = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Booking'),
        centerTitle: true,
        elevation: 2,
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        bloc: context.read<BookingBloc>(),
        builder: (context, state) {
          if (state is BookingLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BookingInitial) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Please select a convenient available slot for the booking:',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  ListTile(
                    leading: Icon(
                      Icons.medical_services_rounded,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "Dr. ${widget.doctorData['full_name']}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.doctorData['clinic']['items'][0]['name']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${widget.doctorData['clinic']['items'][0]['location']}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                ],
              ),
            );
          } else if (state is BookingLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Please select a convenient available slot for the booking:',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  ListTile(
                    leading: Icon(
                      Icons.medical_services_rounded,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "Dr. ${widget.doctorData['full_name']}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.doctorData['clinic']['items'][0]['name']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${widget.doctorData['clinic']['items'][0]['location']}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                  SizedBox(
                    height: 400,
                    child: ListView(
                      children: [
                        for (var i = 0;
                            i < state.bookingData['items'].length;
                            i++)
                          state.bookingData['items'][i]['totalSlots'] > 0
                              ? CheckboxListTile(
                                  value: bookingBools[i],
                                  onChanged: (value) {
                                    bookingBools[i] = value;
                                    selectedBooking["date"] =
                                        state.bookingData['items'][i]['date'];
                                    selectedBooking["activeHour_id"] =
                                        state.bookingData['items'][i]['id'];
                                    selectedBooking['totalSlots'] = state
                                        .bookingData['items'][i]['totalSlots'];
                                    setState(() {});
                                  },
                                  title: Text(DateFormat('EEE dd').format(
                                      DateTime.parse(state.bookingData['items']
                                          [i]['date']))),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 3.0, right: 5),
                                  child: ListTile(
                                    trailing: Icon(
                                      Icons.dangerous_rounded,
                                      size: 30,
                                    ),
                                    horizontalTitleGap: 0,
                                    title: Text(DateFormat('EEE, dd').format(
                                        DateTime.parse(state
                                            .bookingData['items'][i]['date']))),
                                  ),
                                ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(150, 50)),
                      ),
                      child: Text(
                        'Book',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                      onPressed: () async {
                        final user = await Amplify.Auth.getCurrentUser();
                        Map bookingData = {
                          "doctor_id": widget.doctorData["id"],
                          "clinic_id": widget.doctorData['clinic']['items'][0]
                              ['id'],
                          "date": selectedBooking["date"],
                          "location": widget.doctorData['clinic']['items'][0]
                              ['location'],
                          "patient_id": user.userId,
                          "activeHour_id": selectedBooking["activeHour_id"],
                          "totalSlots": selectedBooking['totalSlots'],
                        };
                        context.read<BookingBloc>().add(
                            UserBooksBookingEvent(bookingData: bookingData));
                      },
                    ),
                  )
                ],
              ),
            );
          } else if (state is BookingCancelled) {
            return AlertDialog(
              title: Text('Cancel Booking'),
            );
          } else if (state is BookingSaved) {
            return AlertDialog(
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 100,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Text(
                    'Booking Saved',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    context.read<BookingBloc>().add(UserLoadsBookingEvent());
                  },
                ),
              ],
            );
          } else {
            return Text('SOmething went WRong Reload the Page!');
          }
        },
      ),
    );
  }
}
