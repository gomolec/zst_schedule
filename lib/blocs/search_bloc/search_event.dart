part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class LoadLists extends SearchEvent {
  final List<Class> classesList;
  final List<Classroom> classroomsList;
  final List<Teacher> teachersList;

  const LoadLists({
    required this.classesList,
    required this.classroomsList,
    required this.teachersList,
  });

  @override
  List<Object> get props => [classesList, classroomsList, teachersList];
}

class SearchQuery extends SearchEvent {
  final String query;

  const SearchQuery(this.query);

  @override
  List<Object> get props => [query];
}
