part of 'booking_manager_bloc.dart';

@immutable
abstract class BookingManagerState {}

class BookingManagerInitial extends BookingManagerState {}

class BookingManagerLoading extends BookingManagerState {}

class BookingManagerLoaded extends BookingManagerState {
  BookingManagerLoaded({required this.bookingManagerData});
  final bookingManagerData;
}

class BookingManagerDeleted extends BookingManagerState {
  BookingManagerDeleted({required this.bookingId});
  final String bookingId;
}

class BookingManagerSelected extends BookingManagerState {
  BookingManagerSelected({required this.bookingId});
  final String bookingId;
}
