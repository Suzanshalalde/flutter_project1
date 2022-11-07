import 'package:intl/intl.dart';

class Task {
  final String taskName;
  final bool taskCompleted;
  DateTime dateTime;

  Task(
      {required this.taskName,
      this.taskCompleted = false,
      required this.dateTime});

}
