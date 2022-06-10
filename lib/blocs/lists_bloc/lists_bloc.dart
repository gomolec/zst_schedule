import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zst_schedule/models/models.dart';

import 'package:zst_schedule/repositories/schedule_repo.dart';

part 'lists_event.dart';
part 'lists_state.dart';

class ListsBloc extends Bloc<ListsEvent, ListsState> {
  final ListsRepo repository;
  ListsBloc(
    this.repository,
  ) : super(ListsInitial()) {
    on<GetLists>(
      (event, emit) async {
        var classesList = await repository.getClasses();
        var classroomsList = await repository.getClassrooms();
        var teachersList = await repository.getTeachers();

        emit(
          ListsLoaded(
            classesList: classesList,
            classroomsList: classroomsList,
            teachersList: teachersList,
          ),
        );
      },
    );
  }
}
