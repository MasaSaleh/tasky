import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/date_helper.dart';

class DateTimeline extends StatelessWidget {
  const DateTimeline({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 60,
        itemBuilder: (context, index) {
          final day = DateTime(today.year, today.month, today.day + index);
          final isSelected = DateHelper.sameDay(day, selectedDate);
          final color = isSelected ? Colors.white : null;

          return GestureDetector(
            onTap: () => onDateChanged(day),
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(DateHelper.shortMonth(day),
                      style: TextStyle(fontSize: 13, color: color)),
                  Text('${day.day}',
                      style: TextStyle(fontSize: 26, color: color)),
                  Text(DateHelper.shortDay(day),
                      style: TextStyle(fontSize: 13, color: color)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
