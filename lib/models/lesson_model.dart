import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'classroom_model.dart';
import 'teacher_model.dart';

class Lesson extends Equatable {
  final String name;
  final String? group;
  final Teacher teacher;
  final Classroom classroom;

  const Lesson({
    required this.name,
    this.group,
    required this.teacher,
    required this.classroom,
  });

  Lesson copyWith({
    String? name,
    String? group,
    Teacher? teacher,
    Classroom? classroom,
  }) {
    return Lesson(
      name: name ?? this.name,
      group: group ?? this.group,
      teacher: teacher ?? this.teacher,
      classroom: classroom ?? this.classroom,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'group': group,
      'teacher': teacher.toMap(),
      'classroom': classroom.toMap(),
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      name: map['name'] ?? '',
      group: map['group'],
      teacher: Teacher.fromMap(map['teacher']),
      classroom: Classroom.fromMap(map['classroom']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Lesson.fromJson(String source) => Lesson.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Lesson(name: $name, group: $group, teacher: $teacher, classroom: $classroom)';
  }

  @override
  List<Object?> get props => [name, group, teacher, classroom];
}
