import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zst_schedule/models/models.dart';
import 'package:zst_schedule/repositories/schedule_repo.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ListsRepo repository;
  ScheduleBloc(this.repository) : super(ScheduleInitial()) {
    on<GetSchedule>((event, emit) async {
      emit(ScheduleLoading());

      if (event.classModel != null) {
        var schedule = await repository.getSchedule(
            event.classModel!.link, ScheduleType.scheduleClass);
        emit(
          ScheduleLoaded(schedule: schedule, classModel: event.classModel),
        );
      } else if (event.classroomModel != null) {
        var schedule = await repository.getSchedule(
            event.classroomModel!.link, ScheduleType.scheduleClassroom);
        emit(
          ScheduleLoaded(
              schedule: schedule, classroomModel: event.classroomModel),
        );
      } else if (event.teacherModel != null) {
        var schedule = await repository.getSchedule(
            event.teacherModel!.link, ScheduleType.scheduleTeacher);
        emit(
          ScheduleLoaded(schedule: schedule, teacherModel: event.teacherModel),
        );
      }
    });
  }
}
