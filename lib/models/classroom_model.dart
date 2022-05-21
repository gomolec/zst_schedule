import 'dart:convert';

import 'package:equatable/equatable.dart';

class Classroom extends Equatable {
  final String oldNumber;
  final String? newNumber;
  final String link;

  const Classroom({
    required this.oldNumber,
    this.newNumber,
    required this.link,
  });

  Classroom copyWith({
    String? oldNumber,
    String? newNumber,
    String? link,
  }) {
    return Classroom(
      oldNumber: oldNumber ?? this.oldNumber,
      newNumber: newNumber ?? this.newNumber,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'oldNumber': oldNumber,
      'newNumber': newNumber,
      'link': link,
    };
  }

  factory Classroom.fromMap(Map<String, dynamic> map) {
    return Classroom(
      oldNumber: map['oldNumber'] ?? '',
      newNumber: map['newNumber'],
      link: map['link'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Classroom.fromJson(String source) =>
      Classroom.fromMap(json.decode(source));

  @override
  String toString() =>
      'Classroom(oldNumber: $oldNumber, newNumber: $newNumber, link: $link)';

  @override
  List<Object?> get props => [oldNumber, newNumber, link];
}
