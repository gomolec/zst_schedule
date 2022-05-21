import 'dart:convert';

import 'package:equatable/equatable.dart';

class Teacher extends Equatable {
  final String code;
  final String? fullName;
  final String link;

  const Teacher({
    required this.code,
    this.fullName,
    required this.link,
  });

  Teacher copyWith({
    String? code,
    String? fullName,
    String? link,
  }) {
    return Teacher(
      code: code ?? this.code,
      fullName: fullName ?? this.fullName,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'fullName': fullName,
      'link': link,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      code: map['code'] ?? '',
      fullName: map['fullName'],
      link: map['link'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Teacher.fromJson(String source) =>
      Teacher.fromMap(json.decode(source));

  @override
  String toString() => 'Teacher(code: $code, fullName: $fullName, link: $link)';

  @override
  List<Object?> get props => [code, fullName, link];
}
