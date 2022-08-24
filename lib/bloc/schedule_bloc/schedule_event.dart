part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent {}

class UserUpdateScheduleEvent extends ScheduleEvent {
  UserUpdateScheduleEvent({required this.scheduleData});
  final scheduleData;
}

class UserRefreshScheduleEvent extends ScheduleEvent {}

class UserCancelScheduleEvent extends ScheduleEvent {}
