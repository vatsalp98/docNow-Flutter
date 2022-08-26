part of 'booking_bloc.dart';

@immutable
abstract class BookingEvent {}

class UserLoadsBookingEvent extends BookingEvent {}

class UserBooksBookingEvent extends BookingEvent {
  UserBooksBookingEvent({required this.bookingData});
  final Map bookingData;
}

class UserCancelBookingEvent extends BookingEvent {}
