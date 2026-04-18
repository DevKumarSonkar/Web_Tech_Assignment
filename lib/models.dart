import 'package:flutter/material.dart';

class Task {
  String title;
  DateTime date;
  TimeOfDay time;
  bool isCompleted;

  Task({
    required this.title,
    required this.date,
    required this.time,
    this.isCompleted = false,
  });
}

class Note {
  String title;
  String content;

  Note({
    required this.title,
    required this.content,
  });
}
