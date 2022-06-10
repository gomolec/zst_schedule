import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zst_schedule/blocs/lists_bloc/lists_bloc.dart';
import 'package:zst_schedule/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:zst_schedule/blocs/search_bloc/search_bloc.dart';
import 'package:zst_schedule/models/models.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(
      builder: (context, listsState) {
        if (listsState is ListsLoaded) {
          context.read<SearchBloc>().add(
                LoadLists(
                  classesList: listsState.classesList,
                  classroomsList: listsState.classroomsList,
                  teachersList: listsState.teachersList,
                ),
              );
          return Scaffold(
            appBar: AppBar(
              title: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Znajdz plan lekcji...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white30),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
                onChanged: (query) => context.read<SearchBloc>().add(
                      SearchQuery(query),
                    ),
              ),
            ),
            body: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, searchState) {
                if (searchState is SearchResulted) {
                  return SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: searchState.results.length,
                      itemBuilder: ((context, index) {
                        if (searchState.results[index] is Class) {
                          var classTile = searchState.results[index];
                          return ListTile(
                            leading: Text("${index + 1}."),
                            title: Text(classTile.fullName.toString()),
                            subtitle: Text(classTile.link),
                            onTap: () {
                              // context.read<ScheduleBloc>().add(
                              //     GetSchedule(scheduleLink: classTile.link));
                              // Navigator.pushNamed(
                              //   context,
                              //   '/schedule',
                              //   arguments: classTile,
                              // );
                            },
                          );
                        } else if (searchState.results[index] is Classroom) {
                          var classroomTile = searchState.results[index];
                          return ListTile(
                            leading: Text("${index + 1}."),
                            title: Text(classroomTile.newNumber.toString() +
                                " | " +
                                classroomTile.oldNumber.toString()),
                            subtitle: Text(classroomTile.link),
                            onTap: () {
                              context.read<ScheduleBloc>().add(GetSchedule(
                                  scheduleLink: classroomTile.link));
                              Navigator.pushNamed(
                                context,
                                '/schedule',
                                arguments: classroomTile,
                              );
                            },
                          );
                        } else {
                          var teacherTile = searchState.results[index];
                          return ListTile(
                            leading: Text("${index + 1}."),
                            title: Text(teacherTile.fullName.toString() +
                                " | " +
                                teacherTile.code.toString()),
                            subtitle: Text(teacherTile.link),
                            onTap: () {
                              context.read<ScheduleBloc>().add(
                                  GetSchedule(scheduleLink: teacherTile.link));
                              Navigator.pushNamed(
                                context,
                                '/schedule',
                                arguments: teacherTile,
                              );
                            },
                          );
                        }
                      }),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
