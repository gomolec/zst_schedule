import 'dart:convert';

import 'package:equatable/equatable.dart';

class GroupLesson extends Equatable {
  final int id;
  final String name;
  final int groups;

  const GroupLesson({
    required this.id,
    required this.name,
    required this.groups,
  });

  @override
  List<Object> get props => [id, name, groups];

  @override
  String toString() => 'GroupLesson(id: $id, name: $name, groups: $groups)';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'groups': groups,
    };
  }

  factory GroupLesson.fromMap(Map<String, dynamic> map) {
    return GroupLesson(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      groups: map['groups']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupLesson.fromJson(String source) =>
      GroupLesson.fromMap(json.decode(source));

  GroupLesson copyWith({
    int? id,
    String? name,
    int? groups,
  }) {
    return GroupLesson(
      id: id ?? this.id,
      name: name ?? this.name,
      groups: groups ?? this.groups,
    );
  }
}
