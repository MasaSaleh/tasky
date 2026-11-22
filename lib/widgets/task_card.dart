import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    const white = Colors.white;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.taskColors[task.colorIndex],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                      color: white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      '${task.startTime} - ${task.endTime}',
                      style: const TextStyle(color: white, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  task.description,
                  style: const TextStyle(color: white, fontSize: 16),
                ),
              ],
            ),
          ),
          Container(width: 1, height: 70, color: white.withValues(alpha: 0.6)),
          const SizedBox(width: 10),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isCompleted ? 'COMPLETED' : 'TODO',
              style: const TextStyle(
                  color: white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
