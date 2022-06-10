import 'dart:convert';

import 'package:equatable/equatable.dart';

class Class extends Equatable {
  final String code;
  final String? fullName;
  final String link;

  const Class({
    required this.code,
    required this.fullName,
    required this.link,
  });

  Class copyWith({
    String? code,
    String? fullName,
    String? link,
  }) {
    return Class(
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

  factory Class.fromMap(Map<String, dynamic> map) {
    return Class(
      code: map['code'] ?? '',
      fullName: map['fullName'] ?? '',
      link: map['link'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Class.fromJson(String source) => Class.fromMap(json.decode(source));

  @override
  String toString() => 'Class(code: $code, fullName: $fullName, link: $link)';

  @override
  List<Object?> get props => [code, fullName, link];
}
