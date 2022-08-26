import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repositories/data_repo.dart';

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
    final response = await DataRepo.fetchSlotsForBookingDay();
    emit(BookingLoaded(bookingData: response['listActiveHours']));
  }

  void _saveBooking(
      UserBooksBookingEvent event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    final response = await DataRepo.createBooking(event.bookingData);

    if (response['createBooking']['id'] != null) {
      final response = await DataRepo.updateActiveHoursSlot(
          event.bookingData['totalSlots'], event.bookingData['activeHour_id']);
      if (response['updateActiveHours']['id'] != null) {
        emit(BookingSaved());
        // emit(BookingLoading());
        // final response2 = await DataRepo.fetchSlotsForBookingDay();
        // emit(BookingLoaded(bookingData: response2['listActiveHours']));
      }
    } else {
      emit(BookingCancelled());
    }
  }

  void _cancelBooking(
      UserCancelBookingEvent event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    await const Duration(seconds: 2);
    emit(BookingCancelled());
  }
}
