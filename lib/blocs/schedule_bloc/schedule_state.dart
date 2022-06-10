part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final Schedule schedule;

  const ScheduleLoaded({
    required this.schedule,
  });

  @override
  List<Object> get props => [schedule];
}
