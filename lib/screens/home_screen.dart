import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zst_schedule/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:zst_schedule/models/models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(builder: (context, state) {
      return DefaultTabController(
        length: 5,
        initialIndex: (() {
          int weekday = DateTime.now().weekday;
          if (weekday <= 5) {
            return weekday - 1;
          } else if (weekday == 6) {
            return 4;
          } else {
            return 0;
          }
        }()),
        child: Scaffold(
          appBar: (() {
            if (state is ScheduleLoaded) {
              return const LoadedScheduleAppBar();
            } else if (state is ScheduleInitial) {
              return getDefaultScheduleAppBar();
            }
          }()),
          body: (() {
            if (state is ScheduleLoaded) {
              return LoadedScheduleView(schedule: state.schedule);
            } else if (state is ScheduleInitial) {
              return const WelcomeView();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }()),
          drawer: const MenuDrawer(),
        ),
      );
    });
  }
}

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Header',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.search_rounded),
              title: const Text('Wyszukaj plan lekcji'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  '/search',
                );
              },
              //selected: _selectedDestination == 0,
              //onTap: () => selectDestination(0),
            ),
            const ListTile(
              leading: Icon(Icons.delete),
              title: Text('Item 2'),
              //selected: _selectedDestination == 1,
              //onTap: () => selectDestination(1),
            ),
            const ListTile(
              leading: Icon(Icons.label),
              title: Text('Item 3'),
              //selected: _selectedDestination == 2,
              //onTap: () => selectDestination(2),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Label',
              ),
            ),
            const ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Item A'),
              //selected: _selectedDestination == 3,
              //onTap: () => selectDestination(3),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadedScheduleView extends StatelessWidget {
  final Schedule schedule;
  const LoadedScheduleView({Key? key, required this.schedule})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      ScheduleList(lessons: schedule.schedule[0], maxGroup: schedule.groups),
      ScheduleList(lessons: schedule.schedule[1], maxGroup: schedule.groups),
      ScheduleList(lessons: schedule.schedule[2], maxGroup: schedule.groups),
      ScheduleList(lessons: schedule.schedule[3], maxGroup: schedule.groups),
      ScheduleList(lessons: schedule.schedule[4], maxGroup: schedule.groups),
    ]);
  }
}

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlutterLogo(size: MediaQuery.of(context).size.width / 2),
            Text(
              "Witaj!",
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              "Znajdz swój plan lekcji.",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton.icon(
              icon: const Icon(Icons.search_rounded),
              label: const Text("Wyszukaj"),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/search',
                );
              },
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}

class LoadedScheduleAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const LoadedScheduleAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu_rounded),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: const Text("TYTUŁ"),
      automaticallyImplyLeading: false,
      actions: const [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("GRUPA"),
          ),
        ),
      ],
      bottom: const TabBar(
        indicatorColor: Colors.white,
        isScrollable: true,
        tabs: [
          Tab(text: "Pon."),
          Tab(text: "Wt."),
          Tab(text: "Śr."),
          Tab(text: "Czw."),
          Tab(text: "Pt."),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);
}

AppBar getLoadedScheduleAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.menu_rounded),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    ),
    title: const Text("TYTUŁ"),
    automaticallyImplyLeading: false,
    actions: const [
      Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("GRUPA"),
        ),
      ),
    ],
    bottom: const TabBar(
      indicatorColor: Colors.white,
      isScrollable: true,
      tabs: [
        Tab(text: "Pon."),
        Tab(text: "Wt."),
        Tab(text: "Śr."),
        Tab(text: "Czw."),
        Tab(text: "Pt."),
      ],
    ),
  );
}

AppBar getDefaultScheduleAppBar() {
  return AppBar(
    title: const Text("ZST SCHEDULE"),
  );
}

class ScheduleList extends StatelessWidget {
  final List<List<Lesson>> lessons;
  final int maxGroup;
  const ScheduleList({
    Key? key,
    required this.lessons,
    required this.maxGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: lessons.length,
        itemBuilder: ((context, index) {
          var lesson = lessons[index];

          if (lesson.isNotEmpty) {
            return ListTile(
              leading: Text("$index."),
              title: Text(lesson[0].name),
              trailing: lesson[0].group != null
                  ? Text("${lesson[0].group}/$maxGroup")
                  : null,
              subtitle: Text(lesson[0].classroom.oldNumber +
                  ", " +
                  lesson[0].teacher.code),
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}
