part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object?> get props => [];
}

class GetSchedule extends ScheduleEvent {
  final Class? classModel;
  final Classroom? classroomModel;
  final Teacher? teacherModel;

  const GetSchedule({
    this.classModel,
    this.classroomModel,
    this.teacherModel,
  });

  @override
  List<Object?> get props => [classModel, classroomModel, teacherModel];
}
