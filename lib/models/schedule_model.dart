import 'package:equatable/equatable.dart';

import 'package:zst_schedule/models/lesson_group.dart';

import 'lesson_model.dart';

enum ScheduleType {
  scheduleClass,
  scheduleTeacher,
  scheduleClassroom,
}

class Schedule extends Equatable {
  final ScheduleType type;
  final String validFrom;
  final Map<int, List> hours;
  final int groups;
  final List<GroupLesson>? groupList;
  final List<List<List<Lesson>>> schedule;

  const Schedule({
    required this.type,
    required this.validFrom,
    required this.hours,
    required this.groups,
    this.groupList,
    required this.schedule,
  });

  Schedule copyWith({
    ScheduleType? type,
    String? validFrom,
    Map<int, List>? hours,
    int? groups,
    List<GroupLesson>? groupList,
    List<List<List<Lesson>>>? schedule,
  }) {
    return Schedule(
      type: type ?? this.type,
      validFrom: validFrom ?? this.validFrom,
      hours: hours ?? this.hours,
      groups: groups ?? this.groups,
      groupList: groupList ?? this.groupList,
      schedule: schedule ?? this.schedule,
    );
  }

  @override
  String toString() {
    return 'Schedule(type: $type, validFrom: $validFrom, hours: $hours, groups: $groups, groupList: $groupList, schedule: $schedule)';
  }

  @override
  List<Object?> get props {
    return [
      type,
      validFrom,
      hours,
      groups,
      groupList,
      schedule,
    ];
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'type': type.toMap(),
  //     'validFrom': validFrom,
  //     'hours': hours,
  //     'groups': groups,
  //     'groupList': groupList.map((x) => x.toMap()).toList(),
  //     'schedule': schedule.map((x) => x.toMap()).toList(),
  //   };
  // }

  // factory Schedule.fromMap(Map<String, dynamic> map) {
  //   return Schedule(
  //     type: ScheduleType.fromMap(map['type']),
  //     validFrom: map['validFrom'] ?? '',
  //     hours: Map<int, String>.from(map['hours']),
  //     groups: map['groups']?.toInt() ?? 0,
  //     groupList: List<GroupLesson>.from(
  //         map['groupList']?.map((x) => GroupLesson.fromMap(x))),
  //     schedule: List<List<List<Lesson>>>.from(
  //         map['schedule']?.map((x) => List<List<Lesson>>.fromMap(x))),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Schedule.fromJson(String source) =>
  //     Schedule.fromMap(json.decode(source));
}
