import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:week_of_year/week_of_year.dart';

import '../../repositories/data_repo.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial()) {
    on<UserRefreshScheduleEvent>(_refreshSchedule);
    on<UserUpdateScheduleEvent>(_updateSchedule);
    on<UserCancelScheduleEvent>(_cancelSchedule);
  }

  void _refreshSchedule(
      UserRefreshScheduleEvent event, Emitter<ScheduleState> emit) {
    emit(ScheduleLoading());
    print('HELLLLLLO');
    emit(ScheduleLoading());
  }

  void _updateSchedule(
      UserUpdateScheduleEvent event, Emitter<ScheduleState> emit) {}
  void _cancelSchedule(
      UserCancelScheduleEvent event, Emitter<ScheduleState> emit) {}
}


// if (event is UserRefreshScheduleEvent) {
//         emit(ScheduleLoading());
//         print("HELLLLLO");
//         var response =
//             await DataRepo.fetchActiveHours(DateTime.now().weekOfYear);
//         var scheduleData =
//             json.decode(response['listActiveHours']['items'][0]['schedule']);
//         yield UserUpdateScheduleEvent(scheduleData: scheduleData);
//         emit(ScheduleLoaded());
//       } else if (event is UserCancelScheduleEvent) {
//         emit(ScheduleCancel());
//       }