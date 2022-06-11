part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object?> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final Schedule schedule;
  final Class? classModel;
  final Classroom? classroomModel;
  final Teacher? teacherModel;

  const ScheduleLoaded({
    this.classModel,
    this.classroomModel,
    this.teacherModel,
    required this.schedule,
  });

  @override
  List<Object?> get props =>
      [classModel, classroomModel, teacherModel, schedule];
}
