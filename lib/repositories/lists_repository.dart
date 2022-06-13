import 'dart:convert';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:zst_schedule/models/models.dart';

class ListsRepo {
  static const String url = 'http://www.zstrybnik.pl/html';

  Future<List<Class>> getClassList() async {
    final response = await http.Client().get(Uri.parse(url + '/lista.html'));

    if (response.statusCode == 200) {
      var document = parser.parse(utf8.decode(response.bodyBytes));

      var tabs = document.getElementsByTagName('ul');

      var tabs2 = tabs[0].children;

      List<Class> classes = [];

      for (var item in tabs2) {
        var downloadedNames = item.firstChild?.text ?? '';
        var link = item.firstChild?.attributes['href'] ?? '';

        var names = getClassName(downloadedNames);

        classes.add(
          Class(
            code: names[0],
            fullName: names.length == 2 ? names[1] : null,
            link: link,
          ),
        );
      }
      return classes;
    } else {
      throw Exception('Failed to load classes');
    }
  }

  Future<List<Teacher>> getTeacherList() async {
    final response = await http.Client().get(Uri.parse(url + '/lista.html'));

    if (response.statusCode == 200) {
      var document = parser.parse(utf8.decode(response.bodyBytes));

      var tabs = document.getElementsByTagName('ul');

      var tabs2 = tabs[1].children;

      List<Teacher> teachers = [];

      for (var item in tabs2) {
        var code = item.firstChild?.text ?? '';
        var link = item.firstChild?.attributes['href'] ?? '';

        teachers.add(
          Teacher(code: code, link: link),
        );
      }
      return teachers;
    } else {
      throw Exception('Failed to load teachers');
    }
  }

  Future<List<Classroom>> getClassroomList() async {
    final response = await http.Client().get(Uri.parse(url + '/lista.html'));

    if (response.statusCode == 200) {
      var document = parser.parse(utf8.decode(response.bodyBytes));

      var tabs = document.getElementsByTagName('ul');

      var tabs2 = tabs[2].children;

      List<Classroom> classrooms = [];

      for (var item in tabs2) {
        var downloadedNumbers = item.firstChild?.text ?? '';
        var link = item.firstChild?.attributes['href'] ?? '';

        var numbers = getClassroomNumber(downloadedNumbers);

        classrooms.add(
          Classroom(
            oldNumber: numbers[0],
            newNumber: numbers.length == 2 ? numbers[1] : null,
            link: link,
          ),
        );
      }
      return classrooms;
    } else {
      throw Exception('Failed to load classrooms');
    }
  }

  List<String> getClassName(String downloadedName) {
    var names = downloadedName.split(' ');
    if (names.length > 1) {
      var code = names.removeAt(0);
      return [code, names.join(' ').substring(1)];
    }
    return [downloadedName];
  }

  List<String> getClassroomNumber(String downloadedNumber) {
    var numbers = downloadedNumber.split(' ');
    return numbers;
  }
}
