import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week_of_year/week_of_year.dart';

import '../../repositories/data_repo.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial()) {
    on<UserRefreshScheduleEvent>(_refreshSchedule);
    on<UserSaveScheduleEvent>(_saveSchedule);
    on<UserExitScheduleEvent>(_cancelSchedule);
    on<UserLoadsScheduleEvent>(_loadSchedule);
    on<UserUpdateSlotsScheduleEvent>(_updateSlotNumber);
  }

  @override
  void onTransition(Transition<ScheduleEvent, ScheduleState> transition) {
    print(transition.toString());
    super.onTransition(transition);
  }

  void _updateSlotNumber(
      UserUpdateSlotsScheduleEvent event, Emitter<ScheduleState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final String? slotMap = prefs.getString('slotMap');
    if (slotMap == null) {
      var slotsMap = {"slots": []};
      slotsMap['slots']!.add(
        {"date": event.slotDate, "totalSlots": event.slotNumber},
      );
      prefs.setString('slotMap', json.encode(slotsMap));
    } else {
      var slotsMap = json.decode(slotMap);
      Map newMap = {"date": event.slotDate, "totalSlots": event.slotNumber};
      slotsMap['slots'].add(newMap);
      prefs.setString('slotMap', json.encode(slotsMap));
      print(slotsMap);
    }
  }

  void _loadSchedule(
      UserLoadsScheduleEvent event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoading());
    var scheduleData = await DataRepo.fetchActiveHours(event.weekNumber);
    if (scheduleData['listActiveHours']['items'].length == 0) {
      emit(ScheduleInitial());
    } else {
      print('SCHEDULE DATA:' +
          scheduleData['listActiveHours']['items'].toString());
      emit(
        ScheduleLoaded(scheduleList: scheduleData['listActiveHours']['items']),
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
        ScheduleLoaded(scheduleList: scheduleData['listActiveHours']['items']),
      );
    }
  }

  void _saveSchedule(
      UserSaveScheduleEvent event, Emitter<ScheduleState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final user = await Amplify.Auth.getCurrentUser();
    final Map slotMap = json.decode(prefs.getString('slotMap')!);
    if (slotMap == null) {
      emit(ScheduleInitial());
    } else {
      emit(ScheduleLoading());
      for (var slot in slotMap['slots']) {
        var response = await DataRepo.createActiveHours(
            slot['totalSlots'], event.weekNumber, slot['date']);
      }
      emit(ScheduleSaved());
    }
  }

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