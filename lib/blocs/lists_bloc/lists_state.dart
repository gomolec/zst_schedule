part of 'lists_bloc.dart';

abstract class ListsState extends Equatable {
  const ListsState();

  @override
  List<Object> get props => [];
}

class ListsInitial extends ListsState {}

class ListsLoaded extends ListsState {
  final List<Class> classesList;
  final List<Classroom> classroomsList;
  final List<Teacher> teachersList;

  const ListsLoaded({
    required this.classesList,
    required this.classroomsList,
    required this.teachersList,
  });

  @override
  List<Object> get props => [classesList, classroomsList, teachersList];
}
