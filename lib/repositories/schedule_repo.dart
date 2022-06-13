import 'dart:convert';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:zst_schedule/models/models.dart';

class ScheduleRepo {
  static const String url = 'http://www.zstrybnik.pl/html';

  Future<Schedule> getSchedule(String scheduleUrl, ScheduleType type) async {
    final response =
        await http.Client().get(Uri.parse(url + '/' + scheduleUrl));

    if (response.statusCode == 200) {
      var document = parser.parse(utf8.decode(response.bodyBytes));

      //wiersze planu tabeli z planem lekcji
      var scheduleRows =
          document.getElementsByClassName('tabela')[0].children[0].children;

      //usuwam pierwszy wiersz z zbednymi danymi
      scheduleRows.removeAt(0);

      List<List<List<Lesson>>> schedule = List.generate(
          6, (i) => List.generate(scheduleRows.length, (i) => []));

      Map<int, List> hours = {};
      for (var rows in scheduleRows) {
        hours.addAll({
          int.parse(rows.children[0].text): rows.children[1].text.split('-')
        });
      }

      //licznik grup klasy
      int maxGroup = 1;

      //kolumna planu lekcji
      for (var i = 2; i <= 6; i++) {
        //wiersz planu lekcji
        for (var j = 0; j < scheduleRows.length; j++) {
          var cell = scheduleRows[j].children[i];

          if (type == ScheduleType.scheduleClass) {
            if (cell.children.isNotEmpty) {
              if (cell.children[0].className == 'p') {
                //lekcja całą klasą
                schedule[i - 2][j].add(
                  Lesson(
                    name: cell.children[0].text,
                    teacher: Teacher(
                        code: cell.children[1].text,
                        fullName: null,
                        link: cell.children[1].attributes['href'] ?? ''),
                    classroom: Classroom(
                      newNumber: null,
                      oldNumber: cell.children[2].text,
                      link: cell.children[2].attributes['href'] ?? '',
                    ),
                  ),
                );
              } else {
                //lekcja podzielona na grupy
                for (var groupLesson in cell.children) {
                  if (groupLesson.children.isNotEmpty) {
                    var names = getGroupLesson(groupLesson.children[0].text);
                    if (names[2] > maxGroup) {
                      maxGroup = names[2];
                    }
                    schedule[i - 2][j].add(
                      Lesson(
                        name: names[0],
                        group: names[1],
                        teacher: Teacher(
                            code: groupLesson.children[1].text,
                            fullName: null,
                            link: groupLesson.children[1].attributes['href'] ??
                                ''),
                        classroom: Classroom(
                          newNumber: null,
                          oldNumber: groupLesson.children[2].text,
                          link:
                              groupLesson.children[2].attributes['href'] ?? '',
                        ),
                      ),
                    );
                  }
                }
              }
            }
          } else if (type == ScheduleType.scheduleClassroom) {
            if (cell.children.length == 4) {
              schedule[i - 2][j].add(
                Lesson(
                  name: cell.children[2].text,
                  teacher: Teacher(
                      code: cell.children[0].text,
                      fullName: null,
                      link: cell.children[0].attributes['href'] ?? ''),
                  schoolClass: Class(
                      code: cell.children[1].text,
                      fullName: null,
                      link: cell.children[1].attributes['href'] ?? ''),
                ),
              );
            } else if (cell.children.length > 4) {
              String text = cell.text.split(" ")[1];
              schedule[i - 2][j].add(
                Lesson(
                  name: cell.children[cell.children.length - 2].text, //3
                  teacher: Teacher(
                      code: cell.children[0].text,
                      fullName: null,
                      link: cell.children[0].attributes['href'] ?? ''),
                  schoolClass: Class(
                      code: cell.children[1].text,
                      fullName: null,
                      link: cell.children[1].attributes['href'] ?? ''),
                  optionalText: text,
                ),
              );
            }
          } else if (type == ScheduleType.scheduleTeacher) {
            if (cell.children.length == 1) {
              cell = cell.children[0];
            }
            if (cell.children.length == 10) {
              schedule[i - 2][j].add(
                Lesson(
                  name: cell.children[1].text,
                  schoolClass: Class(
                      code: cell.children[0].text,
                      fullName: null,
                      link: cell.children[0].attributes['href'] ?? ''),
                  classroom: Classroom(
                    newNumber: null,
                    oldNumber: cell.children[2].text,
                    link: cell.children[2].attributes['href'] ?? '',
                  ),
                ),
              );
            } else if (cell.children.length >= 4) {
              String text = cell.text.split(" ")[0];
              schedule[i - 2][j].add(
                Lesson(
                  name: cell.children[cell.children.length - 3].text, //3
                  schoolClass: Class(
                      code: cell.children[0].text,
                      fullName: null,
                      link: cell.children[0].attributes['href'] ?? ''),
                  classroom: Classroom(
                    newNumber: null,
                    oldNumber: cell.children[cell.children.length - 2].text,
                    link: cell.children[cell.children.length - 2]
                            .attributes['href'] ??
                        '',
                  ),
                  optionalText: text,
                ),
              );
            }
          }
        }
      }
      String validFrom = document.body!.children[1].children[0].children[0]
          .children[1].children[0].text;
      return Schedule(
        type: type,
        validFrom: validFrom,
        hours: hours,
        groups: maxGroup,
        schedule: schedule,
      );
    } else {
      throw Exception('Failed to load schedule');
    }
  }

  List getGroupLesson(String downloadedText) {
    var texts = downloadedText.split('-');
    int lessonGroup = int.parse(texts[texts.length - 1].split('/')[0]);
    int scheduleGroups = int.parse(texts[texts.length - 1].split('/')[1]);
    texts.removeLast();
    String lessonName = texts.join('-');
    return [lessonName, lessonGroup, scheduleGroups];
  }
}
