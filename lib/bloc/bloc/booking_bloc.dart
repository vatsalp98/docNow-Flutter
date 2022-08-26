import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<UserLoadsBookingEvent>(_loadBooking);
    on<UserBooksBookingEvent>(_saveBooking);
    on<UserCancelBookingEvent>(_cancelBooking);
  }

  void _loadBooking(
      UserLoadsBookingEvent event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    await const Duration(seconds: 2);
    emit(BookingLoaded());
  }

  void _saveBooking(
      UserBooksBookingEvent event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    await const Duration(seconds: 2);
    emit(BookingSaved());
  }

  void _cancelBooking(
      UserCancelBookingEvent event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    await const Duration(seconds: 2);
    emit(BookingCancelled());
  }
}
