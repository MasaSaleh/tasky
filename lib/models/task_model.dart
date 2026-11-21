// قالب المهمة. هلّق بالذاكرة بس — بنخزّنه بـ Hive بمحاضرة جاية.
class TaskModel {
  final String title;
  final String description;
  final DateTime date;
  final String startTime; // "09:08 PM"
  final String endTime;
  final int colorIndex; // رقم اللون بـ AppColors.taskColors
  bool isCompleted; // مش final: بتتغيّر لما نسحب الكرت لـ Complete

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
