import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zst_schedule/models/models.dart';
import 'package:zst_schedule/repositories/lists_repository.dart';

part 'lists_event.dart';
part 'lists_state.dart';

class ListsBloc extends Bloc<ListsEvent, ListsState> {
  final ListsRepo repository;
  ListsBloc(
    this.repository,
  ) : super(ListsInitial()) {
    on<GetLists>(
      (event, emit) async {
        var classesList = await repository.getClassList();
        var classroomsList = await repository.getClassroomList();
        var teachersList = await repository.getTeacherList();

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
