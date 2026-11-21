import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskati/screens/add_task_screen.dart';

void main() {
  testWidgets('Add Task screen shows its fields', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: AddTaskScreen(initialDate: DateTime.now())),
    );

    expect(find.text('Add Task'), findsOneWidget);
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Create Task'), findsOneWidget);
  });
}
