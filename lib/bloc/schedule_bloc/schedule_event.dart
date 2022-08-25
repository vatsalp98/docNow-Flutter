part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent {}

class UserUpdateScheduleEvent extends ScheduleEvent {
  UserUpdateScheduleEvent({required this.scheduleData});
  final scheduleData;
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
