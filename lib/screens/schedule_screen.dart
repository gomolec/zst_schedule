import 'package:flutter/material.dart';

import 'package:zst_schedule/models/models.dart';
import 'package:zst_schedule/repositories/schedule_repo.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Class;
    var listsRepo = ListsRepo();
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(args.fullName!),
          automaticallyImplyLeading: false,
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(args.code),
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: [
              Tab(
                text: "Pon.",
              ),
              Tab(
                text: "Wt.",
              ),
              Tab(
                text: "Śr.",
              ),
              Tab(
                text: "Czw.",
              ),
              Tab(
                text: "Pt.",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ScheduleList(
                listsRepo: listsRepo, scheduleLink: args.link, index: 0),
            ScheduleList(
                listsRepo: listsRepo, scheduleLink: args.link, index: 1),
            ScheduleList(
                listsRepo: listsRepo, scheduleLink: args.link, index: 2),
            ScheduleList(
                listsRepo: listsRepo, scheduleLink: args.link, index: 3),
            ScheduleList(
                listsRepo: listsRepo, scheduleLink: args.link, index: 4),
          ],
        ),
      ),
    );
  }
}

class ScheduleList extends StatelessWidget {
  const ScheduleList({
    Key? key,
    required this.listsRepo,
    required this.scheduleLink,
    required this.index,
  }) : super(key: key);

  final int index;
  final ListsRepo listsRepo;
  final String scheduleLink;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listsRepo.getSchedule(scheduleLink),
      builder: (BuildContext context, AsyncSnapshot<Schedule> snapshot) {
        if (snapshot.hasData) {
          var scheduleList = snapshot.data!.schedule[index];
          var maxGroup = snapshot.data!.groups;
          return SingleChildScrollView(
            child: ListView.builder(
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
                        ", " +
                        lesson[0].teacher.code),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
