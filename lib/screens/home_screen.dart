import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../core/app_colors.dart';
import '../core/app_strings.dart';
import '../core/date_helper.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';
import '../widgets/date_timeline.dart';
import '../widgets/task_card.dart';
import '../widgets/user_avatar.dart';
import 'add_task_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TaskModel> tasks = []; // بالذاكرة هلّق — Hive بمحاضرة جاية
  DateTime selectedDate = DateTime.now();

  // مهام اليوم المختار بس
  List<TaskModel> get dayTasks =>
      tasks.where((t) => DateHelper.sameDay(t.date, selectedDate)).toList();

  Future<void> openAddTask() async {
    // بنستنّى الشاشة ترجعلنا المهمة الجديدة بـ Navigator.pop
    final task = await Navigator.push<TaskModel>(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(initialDate: selectedDate),
      ),
    );
    if (task != null) setState(() => tasks.add(task));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 20),
              _dateRow(),
              const SizedBox(height: 16),
              DateTimeline(
                selectedDate: selectedDate,
                onDateChanged: (d) => setState(() => selectedDate = d),
              ),
              const SizedBox(height: 20),
              Expanded(child: dayTasks.isEmpty ? _emptyState() : _taskList()),
            ],
          ),
        ),
      ),
    );
  }

  // Hello, Sayed + الصورة — بيسمع للصندوق فبيتحدّث لما تعدّل البروفايل
  Widget _header() {
    return ValueListenableBuilder(
      valueListenable: Hive.box<UserModel>(AppStrings.userBox).listenable(),
      builder: (context, box, _) {
        final user = box.get(AppStrings.userKey);
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${user?.name.split(' ').first ?? ''}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('Have A Nice Day.', style: TextStyle(fontSize: 17)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primary, // الإطار الأزرق
                child: UserAvatar(imagePath: user?.image ?? '', radius: 27),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _dateRow() {
    final isToday = DateHelper.sameDay(selectedDate, DateTime.now());
    const bold = TextStyle(fontSize: 21, fontWeight: FontWeight.bold);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateHelper.full(selectedDate), style: bold),
              Text(isToday ? 'Today' : DateHelper.shortDay(selectedDate),
                  style: bold),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: openAddTask,
          child: const Text('+ Add Task', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget _emptyState() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Image.asset('assets/images/empty_tasks.png', width: 220),
          const SizedBox(height: 16),
          const Text(
            'You do not have any tasks yet!\nAdd new tasks to make your days productive.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _taskList() {
    final list = dayTasks;
    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final task = list[index];
        return Dismissible(
          key: ObjectKey(task),
          // سحب لليمين ← Complete (الكرت بيضل)، سحب لليسار ← Delete
          background: _swipeBackground(
            color: AppColors.green,
            icon: Icons.check,
            text: 'Complete',
            alignment: Alignment.centerLeft,
          ),
          secondaryBackground: _swipeBackground(
            color: AppColors.red,
            icon: Icons.delete,
            text: 'Delete Task',
            alignment: Alignment.centerRight,
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              setState(() => task.isCompleted = true);
              return false; // ما بدنا الكرت يختفي، بس يصير COMPLETED
            }
            return true;
          },
          onDismissed: (_) => setState(() => tasks.remove(task)),
          child: TaskCard(task: task),
        );
      },
    );
  }

  Widget _swipeBackground({
    required Color color,
    required IconData icon,
    required String text,
    required Alignment alignment,
  }) {
    return Container(
      color: color,
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}
