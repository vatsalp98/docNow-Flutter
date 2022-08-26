part of 'booking_bloc.dart';

@immutable
abstract class BookingEvent {}

class UserLoadsBookingEvent extends BookingEvent {}

class UserBooksBookingEvent extends BookingEvent {}

class UserCancelBookingEvent extends BookingEvent {}
