import 'package:flutter/material.dart';
import 'package:zst_schedule/models/models.dart';
import 'package:zst_schedule/screens/schedule_screen/schedule_screen.dart';

class SearchResultTile extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final result;
  const SearchResultTile({
    Key? key,
    this.result,
  }) : super(key: key);

  static Icon searchIcon =
      Icon(Icons.search_rounded, color: Colors.grey.shade400);

  @override
  Widget build(BuildContext context) {
    if (result is Class) {
      return ListTile(
        leading: searchIcon,
        title: Text("Klasa ${result.code} - ${result.fullName}"),
        onTap: () {
          // context
          //     .read<ScheduleBloc>()
          //     .add(GetSchedule(classModel: result));
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            '/schedule',
            arguments: ScheduleScreenArgs(
              type: ScheduleType.scheduleClass,
              schoolClass: result,
            ),
          );
        },
      );
    } else if (result is Classroom) {
      return ListTile(
        leading: searchIcon,
        title: Text(
            "Sala nr. ${result.newNumber ?? ''}${result.oldNumber == null ? '' : " - "}${result.oldNumber ?? ''}"),
        onTap: () {
          // context
          //     .read<ScheduleBloc>()
          //     .add(GetSchedule(classModel: result));
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            '/schedule',
            arguments: ScheduleScreenArgs(
              type: ScheduleType.scheduleClassroom,
              classroom: result,
            ),
          );
        },
      );
    } else if (result is Teacher) {
      return ListTile(
        leading: searchIcon,
        title: Text("Nauczyciel ${result.code}"),
        onTap: () {
          // context
          //     .read<ScheduleBloc>()
          //     .add(GetSchedule(classModel: result));
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            '/schedule',
            arguments: ScheduleScreenArgs(
              type: ScheduleType.scheduleTeacher,
              teacher: result,
            ),
          );
        },
      );
    }
    return const SizedBox();
  }
}

// if (searchState.results[index] is Class) {
//                           var classTile = searchState.results[index];
//                           return ListTile(
//                             leading: Text("${index + 1}."),
//                             title: Text(classTile.fullName.toString()),
//                             subtitle: Text(classTile.link),
                            // onTap: () {
                            //   // context
                            //   //     .read<ScheduleBloc>()
                            //   //     .add(GetSchedule(classModel: classTile));
                            //   Navigator.pop(context);
                            //   Navigator.pushNamed(
                            //     context,
                            //     '/schedule',
                            //     arguments: ScheduleScreenArgs(
                            //       type: ScheduleType.scheduleClass,
                            //       schoolClass: classTile,
                            //     ),
                            //   );
                            // },
//                           );