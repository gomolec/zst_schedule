import 'package:flutter/material.dart';
import 'package:zst_schedule/models/models.dart';
import 'package:zst_schedule/screens/schedule_screen/components/class_schedule_tile.dart';
import 'package:zst_schedule/screens/schedule_screen/components/classroom_schedule_tile.dart';
import 'package:zst_schedule/screens/schedule_screen/components/teacher_schedule_tile.dart';

class ScheduleList extends StatelessWidget {
  final Map<int, List> hours;
  final ScheduleType type;
  final List<List<Lesson>> lessons;
  final int maxGroup;
  const ScheduleList({
    Key? key,
    required this.hours,
    required this.type,
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
            if (type == ScheduleType.scheduleClass) {
              return ClassScheduleTile(
                hours: hours,
                lesson: lesson,
                maxGroup: maxGroup,
                index: index,
              );
            } else if (type == ScheduleType.scheduleClassroom) {
              return ClassroomScheduleTile(
                hours: hours,
                lesson: lesson,
                maxGroup: maxGroup,
                index: index,
              );
            } else if (type == ScheduleType.scheduleTeacher) {
              return TeacherScheduleTile(
                hours: hours,
                lesson: lesson,
                maxGroup: maxGroup,
                index: index,
              );
            }
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
