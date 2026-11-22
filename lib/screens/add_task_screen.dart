import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/date_helper.dart';
import '../models/task_model.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/main_button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, required this.initialDate});

  final DateTime initialDate;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  late DateTime selectedDate = widget.initialDate;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  int selectedColor = 0;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> pickTime({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? startTime : endTime,
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        startTime = picked;
      } else {
        endTime = picked;
      }
    });
  }

  void createTask() {
    final title = titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title')),
      );
      return;
    }

    Navigator.pop(
      context,
      TaskModel(
        title: title,
        description: descriptionController.text.trim(),
        date: selectedDate,
        startTime: startTime.format(context),
        endTime: endTime.format(context),
        colorIndex: selectedColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Task',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'Title',
                        hint: 'Enter title',
                        controller: titleController,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        label: 'Description',
                        hint: 'Enter description',
                        controller: descriptionController,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        label: 'Date',
                        hint: DateHelper.numeric(selectedDate),
                        suffixIcon: Icons.calendar_month_outlined,
                        readOnly: true,
                        showHintAsValue: true,
                        onTap: pickDate,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'Start Time',
                              hint: startTime.format(context),
                              suffixIcon: Icons.access_time,
                              readOnly: true,
                              showHintAsValue: true,
                              onTap: () => pickTime(isStart: true),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomTextField(
                              label: 'End Time',
                              hint: endTime.format(context),
                              suffixIcon: Icons.access_time,
                              readOnly: true,
                              showHintAsValue: true,
                              onTap: () => pickTime(isStart: false),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Color',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(
                          AppColors.taskColors.length,
                          (index) => GestureDetector(
                            onTap: () => setState(() => selectedColor = index),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.taskColors[index],
                                child: selectedColor == index
                                    ? const Icon(Icons.check,
                                        color: Colors.white)
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MainButton(text: 'Create Task', onPressed: createTask),
            ],
          ),
        ),
      ),
    );
  }
}
