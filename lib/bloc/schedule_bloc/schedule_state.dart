part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleCancel extends ScheduleState {}
