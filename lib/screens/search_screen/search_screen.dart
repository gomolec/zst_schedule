import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zst_schedule/blocs/lists_bloc/lists_bloc.dart';
import 'package:zst_schedule/blocs/search_bloc/search_bloc.dart';
import 'package:zst_schedule/screens/search_screen/components/search_result_tile.dart';
import '../../models/filter_arguments_model.dart';
import 'components/filtering_dialog.dart';

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
                        return SearchResultTile(
                            result: searchState.results[index]);
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
