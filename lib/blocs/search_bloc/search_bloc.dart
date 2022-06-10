import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zst_schedule/models/models.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  late List subjects;
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
      List results = searchQuery(event.query);
      emit(SearchResulted(results: results));
    });
  }

  List searchQuery(String query) {
    List results = [];
    for (var subject in subjects) {
      if (subject is Class) {
        if (subject.code.contains(RegExp(query, caseSensitive: false))) {
          results.add(subject);
        } else if (subject.fullName != null) {
          if (subject.fullName!.contains(RegExp(query, caseSensitive: false))) {
            results.add(subject);
          }
        }
      } else if (subject is Classroom) {
        if (subject.oldNumber.contains(RegExp(query, caseSensitive: false))) {
          results.add(subject);
        } else if (subject.newNumber != null) {
          if (subject.newNumber!
              .contains(RegExp(query, caseSensitive: false))) {
            results.add(subject);
          }
        }
      } else if (subject is Teacher) {
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