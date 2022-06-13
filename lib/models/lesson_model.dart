import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:zst_schedule/models/models.dart';

class Lesson extends Equatable {
  final String name;
  final int? group;
  final int? groupId;
  final Teacher? teacher;
  final Classroom? classroom;
  final Class? schoolClass;
  final String? optionalText;

  const Lesson({
    required this.name,
    this.group,
    this.groupId,
    this.teacher,
    this.classroom,
    this.schoolClass,
    this.optionalText,
  });

  Lesson copyWith({
    String? name,
    int? group,
    int? groupId,
    Teacher? teacher,
    Classroom? classroom,
    Class? schoolClass,
    String? optionalText,
  }) {
    return Lesson(
      name: name ?? this.name,
      group: group ?? this.group,
      groupId: groupId ?? this.groupId,
      teacher: teacher ?? this.teacher,
      classroom: classroom ?? this.classroom,
      schoolClass: schoolClass ?? this.schoolClass,
      optionalText: optionalText ?? this.optionalText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'group': group,
      'groupId': groupId,
      'teacher': teacher?.toMap(),
      'classroom': classroom?.toMap(),
      'schoolClass': schoolClass?.toMap(),
      'optionalText': optionalText,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      name: map['name'] ?? '',
      group: map['group']?.toInt(),
      groupId: map['groupId']?.toInt(),
      teacher: map['teacher'] != null ? Teacher.fromMap(map['teacher']) : null,
      classroom:
          map['classroom'] != null ? Classroom.fromMap(map['classroom']) : null,
      schoolClass:
          map['schoolClass'] != null ? Class.fromMap(map['schoolClass']) : null,
      optionalText: map['optionalText'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Lesson.fromJson(String source) => Lesson.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Lesson(name: $name, group: $group, groupId: $groupId, teacher: $teacher, classroom: $classroom, schoolClass: $schoolClass, optionalText: $optionalText)';
  }

  @override
  List<Object?> get props {
    return [
      name,
      group,
      groupId,
      teacher,
      classroom,
      schoolClass,
      optionalText,
    ];
  }
}
