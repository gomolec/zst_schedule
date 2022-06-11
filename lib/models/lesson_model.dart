import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zst_schedule/models/models.dart';

class Lesson extends Equatable {
  final String name;
  final int? group;
  final Teacher? teacher;
  final Classroom? classroom;
  final Class? schoolClass;

  const Lesson({
    required this.name,
    this.group,
    this.teacher,
    this.classroom,
    this.schoolClass,
  });

  Lesson copyWith({
    String? name,
    int? group,
    Teacher? teacher,
    Classroom? classroom,
    Class? schoolClass,
  }) {
    return Lesson(
      name: name ?? this.name,
      group: group ?? this.group,
      teacher: teacher ?? this.teacher,
      classroom: classroom ?? this.classroom,
      schoolClass: schoolClass ?? this.schoolClass,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'group': group,
      'teacher': teacher!.toMap(),
      'classroom': classroom!.toMap(),
      'schoolClass': schoolClass!.toMap(),
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      name: map['name'] ?? '',
      group: map['group']?.toInt(),
      teacher: Teacher.fromMap(map['teacher']),
      classroom: Classroom.fromMap(map['classroom']),
      schoolClass: Class.fromMap(map['schoolClass']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Lesson.fromJson(String source) => Lesson.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Lesson(name: $name, group: $group, teacher: $teacher, classroom: $classroom, schoolClass: $schoolClass)';
  }

  @override
  List<Object?> get props {
    return [
      name,
      group,
      teacher,
      classroom,
      schoolClass,
    ];
  }
}
