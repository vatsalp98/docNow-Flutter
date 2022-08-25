part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  ScheduleLoaded({required this.scheduleList});
  List scheduleList;
}

class ScheduleLoading extends ScheduleState {}

class ScheduleCancel extends ScheduleState {}

class ScheduleSaved extends ScheduleState {}
