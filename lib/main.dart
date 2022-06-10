import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zst_schedule/blocs/lists_bloc/lists_bloc.dart';
import 'package:zst_schedule/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:zst_schedule/blocs/search_bloc/search_bloc.dart';
import 'package:zst_schedule/models/models.dart';
import 'package:zst_schedule/repositories/schedule_repo.dart';
import 'package:zst_schedule/screens/home_screen.dart';
import 'package:zst_schedule/screens/schedule_screen.dart';
import 'package:zst_schedule/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListsRepo listsRepo = ListsRepo();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListsBloc>(
          create: (BuildContext context) =>
              ListsBloc(listsRepo)..add(const GetLists()),
          lazy: false,
        ),
        BlocProvider<ScheduleBloc>(
          create: (BuildContext context) => ScheduleBloc(listsRepo),
          lazy: false,
        ),
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => SearchBloc(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'ZST Schedule',
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/schedule': (context) => const ScheduleScreen(),
          '/search': (context) => const SearchScreen(),
        },
      ),
    );
  }
}

//Poniżej to tylko kopie

class ScheduleList extends StatelessWidget {
  const ScheduleList({
    Key? key,
    required this.listsRepo,
  }) : super(key: key);

  final ListsRepo listsRepo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listsRepo.getSchedule('o23.html'),
      builder: (BuildContext context, AsyncSnapshot<Schedule> snapshot) {
        if (snapshot.hasData) {
          var scheduleList = snapshot.data!.schedule[1];
          var maxGroup = snapshot.data!.groups;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: scheduleList.length,
            itemBuilder: ((context, index) {
              var lesson = scheduleList[index];

              if (lesson.isNotEmpty) {
                return ListTile(
                  leading: Text("$index."),
                  title: Text(lesson[0].name),
                  trailing: lesson[0].group != null
                      ? Text("${lesson[0].group}/$maxGroup")
                      : null,
                  subtitle: Text(lesson[0].classroom.oldNumber +
                      " " +
                      lesson[0].teacher.code),
                );
              } else {
                return const SizedBox();
              }
            }),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class ClassesList extends StatelessWidget {
  const ClassesList({
    Key? key,
    required this.listsRepo,
  }) : super(key: key);

  final ListsRepo listsRepo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                leading: Text("$index."),
                title: Text(
                    schoolClass.code + " | " + schoolClass.fullName.toString()),
                subtitle: Text(schoolClass.link),
              );
            }),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class ClassroomsList extends StatelessWidget {
  const ClassroomsList({
    Key? key,
    required this.listsRepo,
  }) : super(key: key);

  final ListsRepo listsRepo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listsRepo.getClassrooms(),
      builder: (BuildContext context, AsyncSnapshot<List<Classroom>> snapshot) {
        if (snapshot.hasData) {
          var classroomsList = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: classroomsList.length,
            itemBuilder: ((context, index) {
              var classroom = classroomsList[index];
              return ListTile(
                leading: Text("$index."),
                title: Text(classroom.oldNumber +
                    " | " +
                    classroom.newNumber.toString()),
                subtitle: Text(classroom.link),
              );
            }),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class TeachersList extends StatelessWidget {
  const TeachersList({
    Key? key,
    required this.listsRepo,
  }) : super(key: key);

  final ListsRepo listsRepo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listsRepo.getTeachers(),
      builder: (BuildContext context, AsyncSnapshot<List<Teacher>> snapshot) {
        if (snapshot.hasData) {
          var teachersList = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: teachersList.length,
            itemBuilder: ((context, index) {
              var teacher = teachersList[index];
              return ListTile(
                leading: Text("$index."),
                title: Text(teacher.code + " | " + teacher.fullName.toString()),
                subtitle: Text(teacher.link),
              );
            }),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
