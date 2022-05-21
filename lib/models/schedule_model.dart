//import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'lesson_model.dart';

enum Type {
  scheduleClass,
  scheduleTeacher,
  scheduleClassroom,
}

class Schedule extends Equatable {
  final Type type;
  final String validFrom;
  final Map<int, String> hours;
  final List<List<List<Lesson>>> schedule;

  const Schedule({
    required this.type,
    required this.validFrom,
    required this.hours,
    required this.schedule,
  });

  Schedule copyWith({
    Type? type,
    String? validFrom,
    Map<int, String>? hours,
    List<List<List<Lesson>>>? schedule,
  }) {
    return Schedule(
      type: type ?? this.type,
      validFrom: validFrom ?? this.validFrom,
      hours: hours ?? this.hours,
      schedule: schedule ?? this.schedule,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'type': type.toMap(),
  //     'validFrom': validFrom,
  //     'hours': hours,
  //     'schedule': schedule.map((x) => x.toMap()).toList(),
  //   };
  // }

  // factory Schedule.fromMap(Map<String, dynamic> map) {
  //   return Schedule(
  //     type: Type.fromMap(map['type']),
  //     validFrom: map['validFrom'] ?? '',
  //     hours: Map<int, String>.from(map['hours']),
  //     schedule: List<List<List<Lesson>>>.from(map['schedule']?.map((x) => List<List<Lesson>>.fromMap(x))),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Schedule.fromJson(String source) => Schedule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Schedule(type: $type, validFrom: $validFrom, hours: $hours, schedule: $schedule)';
  }

  @override
  List<Object> get props => [type, validFrom, hours, schedule];
}
