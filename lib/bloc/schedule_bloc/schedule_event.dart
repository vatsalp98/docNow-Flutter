part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent {}

class UserSaveScheduleEvent extends ScheduleEvent {
  UserSaveScheduleEvent({required this.weekNumber});
  final weekNumber;
}

class UserRefreshScheduleEvent extends ScheduleEvent {
  UserRefreshScheduleEvent({required this.weekNumber});
  final int weekNumber;
}

class UserExitScheduleEvent extends ScheduleEvent {}

class UserLoadsScheduleEvent extends ScheduleEvent {
  UserLoadsScheduleEvent({required this.weekNumber});
  final int weekNumber;
}

class UserUpdateSlotsScheduleEvent extends ScheduleEvent {
  UserUpdateSlotsScheduleEvent(
      {required this.slotNumber, required this.slotDate});
  final int slotNumber;
  final String slotDate;
}
