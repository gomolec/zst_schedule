import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zst_schedule/models/schedule_model.dart';
import 'package:zst_schedule/repositories/schedule_repo.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ListsRepo repository;
  ScheduleBloc(this.repository) : super(ScheduleInitial()) {
    on<GetSchedule>((event, emit) async {
      var schedule = await repository.getSchedule(event.scheduleLink);

      emit(ScheduleLoaded(schedule: schedule));
    });
  }
}
