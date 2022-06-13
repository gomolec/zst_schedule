import 'package:flutter/material.dart';
import 'package:zst_schedule/models/models.dart';
import 'package:zst_schedule/screens/schedule_screen/components/class_lesson_dialog.dart';
import 'package:zst_schedule/string_extencions.dart';

class ClassScheduleTile extends StatelessWidget {
  const ClassScheduleTile({
    Key? key,
    required this.hours,
    required this.lesson,
    required this.maxGroup,
    required this.index,
  }) : super(key: key);

  final Map<int, List> hours;
  final List<Lesson> lesson;
  final int maxGroup;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return ClassLessonDialog(
                hours: hours,
                lesson: lesson,
                maxGroup: maxGroup,
                index: index,
              );
            });
      },
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            width: 40.0,
            child: Text(
              "$index.",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${hours[index]![0]}"),
              const SizedBox(height: 8),
              Text("${hours[index]![1]}"),
            ],
          )
        ],
      ),
      title: Text(lesson[0].name.capitalize()),
      trailing:
          lesson[0].group != null ? Text("${lesson[0].group}/$maxGroup") : null,
      subtitle: Text((() {
        String _text = '';
        if (lesson[0].classroom!.newNumber != null) {
          _text +=
              "${lesson[0].classroom!.newNumber} (${lesson[0].classroom!.oldNumber})";
        } else {
          _text += lesson[0].classroom!.oldNumber;
        }
        _text += ", ";
        if (lesson[0].teacher!.fullName != null) {
          _text +=
              "${lesson[0].teacher!.fullName} (${lesson[0].teacher!.code})";
        } else {
          _text += lesson[0].teacher!.code;
        }
        return _text;
      }())),
    );
  }
}
