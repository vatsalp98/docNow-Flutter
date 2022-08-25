part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  ScheduleLoaded({required this.scheduleData});
  Map scheduleData;
}

class ScheduleLoading extends ScheduleState {}

class ScheduleCancel extends ScheduleState {}
