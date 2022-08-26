import 'package:docnow/bloc/booking_manager_bloc/booking_manager_bloc.dart';
import 'package:docnow/widgets/nameFromId.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/booking_bloc/booking_bloc.dart';
import '../widgets/clinicNameFromId.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Bookings',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.grey[50],
        ),
        body: BlocBuilder<BookingManagerBloc, BookingManagerState>(
          bloc: context.read<BookingManagerBloc>(),
          builder: (context, state) {
            if (state is BookingManagerLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BookingManagerSelected) {
              return AlertDialog(
                title: Text(state.bookingId),
                actions: [
                  TextButton(
                    child: Text('Cancel Booking'),
                    onPressed: () {
                      context.read<BookingManagerBloc>().add(
                            UserDeleteBookingManagerEvent(
                              bookingId: state.bookingId,
                            ),
                          );
                    },
                  ),
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      context
                          .read<BookingManagerBloc>()
                          .add(UserLoadsBookingManagerEvent());
                    },
                  ),
                ],
              );
            } else if (state is BookingManagerLoaded) {
              print(state.bookingManagerData);
              return SizedBox(
                child: ListView(
                  children: [
                    if (state.bookingManagerData['items'].length == 0)
                      Center(child: Text('No Bookings Found!')),
                    for (var booking in state.bookingManagerData['items'])
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            context.read<BookingManagerBloc>().add(
                                  UserDeleteBookingManagerEvent(
                                    bookingId: booking['id'],
                                  ),
                                );
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.medical_information_rounded,
                              color: Colors.blue[700],
                            ),
                            title: nameFromId(context, booking['doctor_id']),
                            isThreeLine: true,
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClinicNameFromId(context, booking['clinic_id']),
                                Text(
                                  DateFormat('hh:MM a').format(
                                      DateTime.parse(booking["booking_time"])),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Text(
                              DateFormat('EEE dd').format(
                                  DateTime.parse(booking["booking_date"])),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            } else if (state is BookingManagerInitial) {
              return Text('INitial');
            } else if (state is BookingManagerDeleted) {
              return AlertDialog(
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Are you sure you want to delete this Booking ?'),
                    Text(state.bookingId),
                  ],
                ),
                title: Text('Delete Booking'),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.read<BookingManagerBloc>().add(
                          UserDeleteBookingManagerEvent(
                              bookingId: state.bookingId));
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'No',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onPressed: () {
                      context
                          .read<BookingManagerBloc>()
                          .add(UserLoadsBookingManagerEvent());
                    },
                  )
                ],
              );
            } else {
              return Text('Something went Wrong');
            }
          },
        ),
      ),
    );
  }
}
