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
    on<UserExitScheduleEvent>(_cancelSchedule);
    on<UserLoadsScheduleEvent>(_loadSchedule);
  }

  @override
  void onTransition(Transition<ScheduleEvent, ScheduleState> transition) {
    print(transition.toString());
    super.onTransition(transition);
  }

  void _loadSchedule(
      UserLoadsScheduleEvent event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoading());
    var scheduleData = await DataRepo.fetchActiveHours(event.weekNumber);
    if (scheduleData['listActiveHours']['items'].length == 0) {
      emit(ScheduleInitial());
    } else {
      print('SCHEDULE DATA:' +
          scheduleData['listActiveHours']['items'][0].toString());
      emit(
        ScheduleLoaded(
            scheduleData: scheduleData['listActiveHours']['items'][0]),
      );
    }
  }

  void _refreshSchedule(
      UserRefreshScheduleEvent event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoading());
    var scheduleData = await DataRepo.fetchActiveHours(event.weekNumber);
    if (scheduleData['listActiveHours']['items'].length == 0) {
      emit(ScheduleInitial());
    } else {
      print('SCHEDULE DATA:' +
          scheduleData['listActiveHours']['items'][0].toString());
      emit(
        ScheduleLoaded(
            scheduleData: scheduleData['listActiveHours']['items'][0]),
      );
    }
  }

  void _updateSchedule(
      UserUpdateScheduleEvent event, Emitter<ScheduleState> emit) {}

  void _cancelSchedule(
      UserExitScheduleEvent event, Emitter<ScheduleState> emit) {
    emit(ScheduleCancel());
  }
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