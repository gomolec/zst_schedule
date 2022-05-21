import 'package:flutter/material.dart';
import 'package:zst_schedule/models/models.dart';
import 'package:zst_schedule/repositories/schedule_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listsRepo = ListsRepo();
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("ZST SCHEDULE"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                child: const Text("Download classes"),
                onPressed: () async {
                  print(await listsRepo.getClasses());
                },
              ),
              ElevatedButton(
                child: const Text("Download teachers"),
                onPressed: () async {
                  print(await listsRepo.getTeachers());
                },
              ),
              ElevatedButton(
                child: const Text("Download classrooms"),
                onPressed: () async {
                  print(await listsRepo.getClassrooms());
                },
              ),
              ElevatedButton(
                child: const Text("Download schedule"),
                onPressed: () async {
                  print(await listsRepo.getSchedule());
                },
              ),
              FutureBuilder(
                future: listsRepo.getSchedule(),
                builder:
                    (BuildContext context, AsyncSnapshot<Schedule> snapshot) {
                  if (snapshot.hasData) {
                    var scheduleList = snapshot.data!.schedule[1];
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: scheduleList.length,
                      itemBuilder: ((context, index) {
                        var lesson = scheduleList[index];

                        if (lesson.isNotEmpty) {
                          return ListTile(
                            leading: Text("$index."),
                            title: Text(lesson[0].name),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
