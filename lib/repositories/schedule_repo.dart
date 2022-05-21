import 'dart:convert';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:zst_schedule/models/models.dart';

class ListsRepo {
  static const String listsUrl = 'http://www.zstrybnik.pl/html/lista.html';
  static const String schedulesUrl =
      'http://www.zstrybnik.pl/html/plany/o23.html';

  Future<List<Class>> getClasses() async {
    final response = await http.Client().get(Uri.parse(listsUrl));

    if (response.statusCode == 200) {
      var document = parser.parse(utf8.decode(response.bodyBytes));

      var tabs = document.getElementsByTagName('ul');

      var tabs2 = tabs[0].children;

      List<Class> classes = [];

      for (var item in tabs2) {
        var code = item.firstChild?.text ?? '';
        var link = item.firstChild?.attributes['href'] ?? '';

        classes.add(Class(code: code, fullName: code, link: link));
      }
      return classes;
    } else {
      throw Exception('Failed to load classes');
    }
  }

  Future<List<Teacher>> getTeachers() async {
    final response = await http.Client().get(Uri.parse(listsUrl));

    if (response.statusCode == 200) {
      var document = parser.parse(utf8.decode(response.bodyBytes));

      var tabs = document.getElementsByTagName('ul');

      var tabs2 = tabs[1].children;

      List<Teacher> teachers = [];

      for (var item in tabs2) {
        var code = item.firstChild?.text ?? '';
        var link = item.firstChild?.attributes['href'] ?? '';

        teachers.add(Teacher(code: code, link: link));
      }
      return teachers;
    } else {
      throw Exception('Failed to load teachers');
    }
  }

  Future<List<Classroom>> getClassrooms() async {
    final response = await http.Client().get(Uri.parse(listsUrl));

    if (response.statusCode == 200) {
      var document = parser.parse(utf8.decode(response.bodyBytes));

      var tabs = document.getElementsByTagName('ul');

      var tabs2 = tabs[2].children;

      List<Classroom> classrooms = [];

      for (var item in tabs2) {
        var numbers = item.firstChild?.text ?? '';
        var link = item.firstChild?.attributes['href'] ?? '';

        classrooms.add(Classroom(oldNumber: numbers, link: link));
      }
      return classrooms;
    } else {
      throw Exception('Failed to load classrooms');
    }
  }

  Future<Schedule> getSchedule() async {
    final response = await http.Client().get(Uri.parse(schedulesUrl));

    if (response.statusCode == 200) {
      var document = parser.parse(utf8.decode(response.bodyBytes));

      //wiersze planu tabeli z planem lekcji
      var scheduleRows =
          document.getElementsByClassName('tabela')[0].children[0].children;

      //usuwam pierwszy wiersz z zbednymi danymi
      scheduleRows.removeAt(0);

      List<List<List<Lesson>>> schedule = List.generate(
          6, (i) => List.generate(scheduleRows.length, (i) => []));

      Map<int, String> hours = {};
      for (var rows in scheduleRows) {
        hours.addAll({int.parse(rows.children[0].text): rows.children[1].text});
      }

      //kolumna planu lekcji
      for (var i = 2; i <= 6; i++) {
        //wiersz planu lekcji
        for (var j = 0; j < scheduleRows.length; j++) {
          var cell = scheduleRows[j].children[i];

          if (cell.children.isNotEmpty) {
            if (cell.children[0].className == 'p') {
              schedule[i - 2][j].add(
                Lesson(
                  name: cell.children[0].text,
                  teacher: Teacher(
                      code: cell.children[1].text,
                      fullName: '',
                      link: cell.children[1].attributes['href'] ?? ''),
                  classroom: Classroom(
                    newNumber: '',
                    oldNumber: cell.children[2].text,
                    link: cell.children[2].attributes['href'] ?? '',
                  ),
                ),
              );
            } else {
              for (var groupLesson in cell.children) {
                if (groupLesson.children.isNotEmpty) {
                  schedule[i - 2][j].add(
                    Lesson(
                      name: groupLesson.children[0].text,
                      teacher: Teacher(
                          code: groupLesson.children[1].text,
                          fullName: '',
                          link:
                              groupLesson.children[1].attributes['href'] ?? ''),
                      classroom: Classroom(
                        newNumber: '',
                        oldNumber: groupLesson.children[2].text,
                        link: groupLesson.children[2].attributes['href'] ?? '',
                      ),
                    ),
                  );
                }
              }
            }
          }
        }
      }
      String validFrom = document.body!.children[1].children[0].children[0]
          .children[1].children[0].text;
      return Schedule(
        type: Type.scheduleClass,
        validFrom: validFrom,
        hours: hours,
        schedule: schedule,
      );
    } else {
      throw Exception('Failed to load schedule');
    }
  }
}
