import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zst_schedule/bloc/lists_bloc.dart';
import 'package:zst_schedule/models/models.dart';
import 'package:zst_schedule/repositories/schedule_repo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ZST schedule"),
      ),
      body: const ClassesList(),
    );
  }
}

class ClassesList extends StatelessWidget {
  const ClassesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(
      builder: ((context, state) {
        if (state is ListsLoaded) {
          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.classesList.length,
              itemBuilder: ((context, index) {
                var schoolClass = state.classesList[index];
                return ListTile(
                  leading: Text("${index + 1}."),
                  title: Text(schoolClass.code +
                      " | " +
                      schoolClass.fullName.toString()),
                  subtitle: Text(schoolClass.link),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/schedule',
                      arguments: schoolClass,
                    );
                  },
                );
              }),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

class ClassesList1 extends StatelessWidget {
  const ClassesList1({
    Key? key,
    required this.listsRepo,
  }) : super(key: key);

  final ListsRepo listsRepo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: listsRepo.getClasses(),
        builder: (BuildContext context, AsyncSnapshot<List<Class>> snapshot) {
          if (snapshot.hasData) {
            var classesList = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: classesList.length,
              itemBuilder: ((context, index) {
                var schoolClass = classesList[index];
                return ListTile(
                  leading: Text("${index + 1}."),
                  title: Text(schoolClass.code +
                      " | " +
                      schoolClass.fullName.toString()),
                  subtitle: Text(schoolClass.link),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/schedule',
                      arguments: schoolClass,
                    );
                  },
                );
              }),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
