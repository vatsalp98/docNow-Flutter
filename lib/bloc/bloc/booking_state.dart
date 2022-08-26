part of 'booking_bloc.dart';

@immutable
abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {}

class BookingSaved extends BookingState {}

class BookingCancelled extends BookingState {}
