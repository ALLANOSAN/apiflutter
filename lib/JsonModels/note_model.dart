import 'dart:convert';

import 'package:flutter/material.dart';

List<Note> noteFromJson(String str) =>
    List<Note>.from(json.decode(str).map((x) => Note.fromJson(x)));

String noteToJson(List<Note> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Note {
  Note({
    this.id,
    required this.title,
    required this.content,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
  });

  int? id;
  String title;
  String content;
  DateTime startDate;
  TimeOfDay startTime;
  DateTime endDate;
  TimeOfDay endTime;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        startDate: DateTime.parse(json["startDate"]),
        startTime: TimeOfDay.fromDateTime(DateTime.parse(json["startTime"])),
        endDate: DateTime.parse(json["endDate"]),
        endTime: TimeOfDay.fromDateTime(DateTime.parse(json["endTime"])),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "startDate": startDate.toIso8601String(),
        "startTime": DateTime(
          2000,
          1,
          1,
          startTime.hour,
          startTime.minute,
        ).toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "endTime": DateTime(
          2000,
          1,
          1,
          endTime.hour,
          endTime.minute,
        ).toIso8601String(),
      };

  Note copy({
    int? id,
    String? title,
    String? content,
    DateTime? startDate,
    TimeOfDay? startTime,
    DateTime? endDate,
    TimeOfDay? endTime,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        startDate: startDate ?? this.startDate,
        startTime: startTime ?? this.startTime,
        endDate: endDate ?? this.endDate,
        endTime: endTime ?? this.endTime,
      );
}
