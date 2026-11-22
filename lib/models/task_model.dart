class TaskModel {
  final String title;
  final String description;
  final DateTime date;
  final String startTime;
  final String endTime;
  final int colorIndex;
  bool isCompleted;

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.colorIndex,
    this.isCompleted = false,
  });
}
