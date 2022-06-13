import 'package:flutter/material.dart';
import 'package:zst_schedule/models/models.dart';
import 'package:zst_schedule/string_extencions.dart';

class ClassLessonDialog extends StatelessWidget {
  final Map<int, List> hours;
  final List<Lesson> lesson;
  final int maxGroup;
  final int index;
  const ClassLessonDialog({
    Key? key,
    required this.hours,
    required this.lesson,
    required this.maxGroup,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Szczegóły"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lekcja",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            lesson[0].name.capitalize(),
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            "Sala lekcyjna",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            lesson[0].classroom!.oldNumber,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            "Nauczyciel",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            lesson[0].teacher!.code,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            "Godziny",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            "${hours[index]![0].toString().trimLeft()}-${hours[index]![1]}",
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Wyjdz'),
        ),
      ],
    );
  }
}
