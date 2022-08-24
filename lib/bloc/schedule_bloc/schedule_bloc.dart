import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:week_of_year/week_of_year.dart';

import '../../repositories/data_repo.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial()) {
    on<ScheduleEvent>((event, emit) async* {
      if (event is UserRefreshScheduleEvent) {
        emit(ScheduleLoading());
        print("HELLLLLO");
        var response =
            await DataRepo.fetchActiveHours(DateTime.now().weekOfYear);
        var scheduleData =
            json.decode(response['listActiveHours']['items'][0]['schedule']);
        yield UserUpdateScheduleEvent(scheduleData: scheduleData);
        emit(ScheduleLoaded());
      } else if (event is UserCancelScheduleEvent) {
        emit(ScheduleCancel());
      }
    });
  }
}
