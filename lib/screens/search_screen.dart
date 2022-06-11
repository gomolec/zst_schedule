import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zst_schedule/blocs/lists_bloc/lists_bloc.dart';
import 'package:zst_schedule/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:zst_schedule/blocs/search_bloc/search_bloc.dart';
import 'package:zst_schedule/models/models.dart';

class FilterArguments {
  bool showClasses;
  bool showClassrooms;
  bool showTeachers;

  FilterArguments({
    this.showClasses = true,
    this.showClassrooms = true,
    this.showTeachers = true,
  });
  void handleFiltersChanged(
    FilterArguments changes,
  ) {
    showClasses = changes.showClasses;
    showClassrooms = changes.showClassrooms;
    showTeachers = changes.showTeachers;
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilterArguments filters =
        (ModalRoute.of(context)!.settings.arguments == null)
            ? FilterArguments()
            : (ModalRoute.of(context)!.settings.arguments as FilterArguments);
    return BlocBuilder<ListsBloc, ListsState>(
      builder: (context, listsState) {
        if (listsState is ListsLoaded) {
          if (context.read<SearchBloc>().state is SearchInitial) {
            context.read<SearchBloc>().add(
                  LoadLists(
                    classesList: listsState.classesList,
                    classroomsList: listsState.classroomsList,
                    teachersList: listsState.teachersList,
                  ),
                );
          }
          context.read<SearchBloc>().add(FilterSearch(
                showClasses: filters.showClasses,
                showClassrooms: filters.showClassrooms,
                showTeachers: filters.showClassrooms,
                query: '',
              ));
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
              actions: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return FilteringDialog(
                            showClasses: filters.showClasses,
                            showClassrooms: filters.showClassrooms,
                            showTeachers: filters.showTeachers,
                            onChanged: filters.handleFiltersChanged,
                          );
                        });
                  },
                  icon: const Icon(Icons.sort_rounded),
                )
              ],
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
                              context
                                  .read<ScheduleBloc>()
                                  .add(GetSchedule(classModel: classTile));
                              Navigator.pop(context);
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
                              context.read<ScheduleBloc>().add(
                                  GetSchedule(classroomModel: classroomTile));
                              Navigator.pop(context);
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
                              context
                                  .read<ScheduleBloc>()
                                  .add(GetSchedule(teacherModel: teacherTile));
                              Navigator.pop(context);
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

class FilteringDialog extends StatefulWidget {
  final bool showClasses;
  final bool showClassrooms;
  final bool showTeachers;
  final ValueChanged<FilterArguments> onChanged;
  const FilteringDialog({
    Key? key,
    required this.showClasses,
    required this.showClassrooms,
    required this.showTeachers,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FilteringDialog> createState() => _SortingDialogState();
}

class _SortingDialogState extends State<FilteringDialog> {
  late bool showClasses;
  late bool showClassrooms;
  late bool showTeachers;

  @override
  void initState() {
    super.initState();
    showClasses = widget.showClasses;
    showClassrooms = widget.showClassrooms;
    showTeachers = widget.showTeachers;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filtrowanie'),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: const Text('Klasy'),
            value: showClasses,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  showClasses = value;
                });
              }
            },
          ),
          CheckboxListTile(
            title: const Text('Sale lekcyjne'),
            value: showClassrooms,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  showClassrooms = value;
                });
              }
            },
          ),
          CheckboxListTile(
            title: const Text('Nauczyciele'),
            value: showTeachers,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  showTeachers = value;
                });
              }
            },
          )
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Anuluj'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<SearchBloc>().add(FilterSearch(
                  showClasses: showClasses,
                  showClassrooms: showClassrooms,
                  showTeachers: showTeachers,
                ));
            widget.onChanged(FilterArguments(
              showClasses: showClasses,
              showClassrooms: showClassrooms,
              showTeachers: showTeachers,
            ));
            Navigator.pop(context);
          },
          child: const Text('Zapisz'),
        ),
      ],
    );
  }
}
