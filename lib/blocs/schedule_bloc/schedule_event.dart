part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class GetSchedule extends ScheduleEvent {
  final String scheduleLink;

  const GetSchedule({
    required this.scheduleLink,
  });

  @override
  List<Object> get props => [scheduleLink];
}
