part of 'booking_manager_bloc.dart';

@immutable
abstract class BookingManagerEvent {}

class UserLoadsBookingManagerEvent extends BookingManagerEvent {}

class UserRefreshBookingManagerEvent extends BookingManagerEvent {}

class UserDeleteBookingManagerEvent extends BookingManagerEvent {
  UserDeleteBookingManagerEvent({required this.bookingId});
  final String bookingId;
}

class UserViewBookingManagerEvent extends BookingManagerEvent {
  UserViewBookingManagerEvent({required this.bookingId});
  final String bookingId;
}
