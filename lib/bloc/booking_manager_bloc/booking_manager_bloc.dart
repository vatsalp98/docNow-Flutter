import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repositories/data_repo.dart';

part 'booking_manager_event.dart';
part 'booking_manager_state.dart';

class BookingManagerBloc
    extends Bloc<BookingManagerEvent, BookingManagerState> {
  BookingManagerBloc() : super(BookingManagerInitial()) {
    on<UserLoadsBookingManagerEvent>(_loadBookingManager);
    on<UserRefreshBookingManagerEvent>(_refreshBookingManager);
    on<UserDeleteBookingManagerEvent>(_deleteBookingManager);
    on<UserViewBookingManagerEvent>(_selectBookingManager);
  }

  @override
  void onTransition(
      Transition<BookingManagerEvent, BookingManagerState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  void _loadBookingManager(UserLoadsBookingManagerEvent event,
      Emitter<BookingManagerState> emit) async {
    emit(BookingManagerLoading());
    var response = await DataRepo.fetchUserBookings();
    emit(BookingManagerLoaded(bookingManagerData: response['listBookings']));
  }

  void _refreshBookingManager(UserRefreshBookingManagerEvent event,
      Emitter<BookingManagerState> emit) async {
    emit(BookingManagerLoading());
    var response = await DataRepo.fetchUserBookings();
    emit(BookingManagerLoaded(bookingManagerData: response['listBookings']));
  }

  void _deleteBookingManager(UserDeleteBookingManagerEvent event,
      Emitter<BookingManagerState> emit) async {
    emit(BookingManagerLoading());
    emit(BookingManagerDeleted(bookingId: event.bookingId));
    final response = await DataRepo.deleteBooking(event.bookingId);
    var response2 = await DataRepo.fetchUserBookings();
    emit(BookingManagerLoaded(bookingManagerData: response2['listBookings']));
  }

  void _selectBookingManager(
      UserViewBookingManagerEvent event, Emitter<BookingManagerState> emit) {
    emit(BookingManagerLoading());
    emit(BookingManagerSelected(bookingId: event.bookingId));
  }
}
