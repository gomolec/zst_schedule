import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zst_schedule/models/models.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  late List subjects;
  bool showClasses = true;
  bool showClassrooms = true;
  bool showTeachers = true;
  late String query;
  SearchBloc() : super(SearchInitial()) {
    on<LoadLists>((event, emit) {
      subjects = [];
      subjects += event.classesList;
      subjects += event.classroomsList;
      subjects += event.teachersList;
      emit(SearchResulted(results: subjects));
    });
    on<SearchQuery>((event, emit) {
      emit(SearchLoading());
      query = event.query;
      List results = searchQuery(
        query: query,
        showClasses: showClasses,
        showClassrooms: showClassrooms,
        showTeachers: showTeachers,
      );
      emit(SearchResulted(results: results));
    });
    on<FilterSearch>(((event, emit) {
      if (event.query != null) {
        query = event.query!;
      }
      showClasses = event.showClasses;
      showClassrooms = event.showClassrooms;
      showTeachers = event.showTeachers;

      List results = searchQuery(
        query: query,
        showClasses: showClasses,
        showClassrooms: showClassrooms,
        showTeachers: showTeachers,
      );
      emit(SearchResulted(results: results));
    }));
  }

  List searchQuery({
    required String query,
    required bool showClasses,
    required bool showClassrooms,
    required bool showTeachers,
  }) {
    List results = [];
    for (var subject in subjects) {
      if (subject is Class && showClasses == true) {
        if (subject.code.contains(RegExp(query, caseSensitive: false))) {
          results.add(subject);
        } else if (subject.fullName != null) {
          if (subject.fullName!.contains(RegExp(query, caseSensitive: false))) {
            results.add(subject);
          }
        }
      } else if (subject is Classroom && showClassrooms == true) {
        if (subject.oldNumber.contains(RegExp(query, caseSensitive: false))) {
          results.add(subject);
        } else if (subject.newNumber != null) {
          if (subject.newNumber!
              .contains(RegExp(query, caseSensitive: false))) {
            results.add(subject);
          }
        }
      } else if (subject is Teacher && showTeachers == true) {
        if (subject.code.contains(RegExp(query, caseSensitive: false))) {
          results.add(subject);
        } else if (subject.fullName != null) {
          if (subject.fullName!.contains(RegExp(query, caseSensitive: false))) {
            results.add(subject);
          }
        }
      }
    }
    return results;
  }
}

//String.contains(RegExp(searchText, caseSensitive: false))

// lista.map((subject) {
//     if (subject is Teacher) {
//       if (subject.code.contains(RegExp(searchText, caseSensitive: false))) {
//         newList.add(subject);
//       }
//     }
//     if (subject is Classroom) {
//       if (subject.oldNumber.contains(RegExp(searchText, caseSensitive: false))) {
//         newList.add(subject);
//       }
//     }
//   }).toList();