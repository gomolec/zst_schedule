import 'package:flutter/material.dart';
import 'package:zst_schedule/models/models.dart';
import 'package:zst_schedule/repositories/schedule_repo.dart';
import 'package:zst_schedule/screens/schedule_screen/components/schedule_list.dart';

class ScheduleScreenArgs {
  final ScheduleType type;
  final Class? schoolClass;
  final Classroom? classroom;
  final Teacher? teacher;

  ScheduleScreenArgs({
    required this.type,
    this.schoolClass,
    this.classroom,
    this.teacher,
  });
}

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ScheduleScreenArgs;
    final scheduleRepo = ScheduleRepo();
    late String title;
    late String link;
    if (args.type == ScheduleType.scheduleClass) {
      title = args.schoolClass!.code;
      link = args.schoolClass!.link;
    } else if (args.type == ScheduleType.scheduleClassroom) {
      title = args.classroom!.oldNumber;
      link = args.classroom!.link;
    } else if (args.type == ScheduleType.scheduleTeacher) {
      title = args.teacher!.code;
      link = args.teacher!.link;
    } else {
      title = "TITLE";
    }
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
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
        body: FutureBuilder(
          future: scheduleRepo.getSchedule(link, args.type),
          builder: (BuildContext context, AsyncSnapshot<Schedule> snapshot) {
            if (snapshot.hasData) {
              return TabBarView(
                children: [
                  ScheduleList(
                    lessons: snapshot.data!.schedule[0],
                    maxGroup: snapshot.data!.groups,
                    type: snapshot.data!.type,
                    hours: snapshot.data!.hours,
                  ),
                  ScheduleList(
                    lessons: snapshot.data!.schedule[1],
                    maxGroup: snapshot.data!.groups,
                    type: snapshot.data!.type,
                    hours: snapshot.data!.hours,
                  ),
                  ScheduleList(
                    lessons: snapshot.data!.schedule[2],
                    maxGroup: snapshot.data!.groups,
                    type: snapshot.data!.type,
                    hours: snapshot.data!.hours,
                  ),
                  ScheduleList(
                    lessons: snapshot.data!.schedule[3],
                    maxGroup: snapshot.data!.groups,
                    type: snapshot.data!.type,
                    hours: snapshot.data!.hours,
                  ),
                  ScheduleList(
                    lessons: snapshot.data!.schedule[4],
                    maxGroup: snapshot.data!.groups,
                    type: snapshot.data!.type,
                    hours: snapshot.data!.hours,
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
