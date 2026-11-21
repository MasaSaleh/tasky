// تنسيق التواريخ بدون مكتبة إضافية
class DateHelper {
  static const _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  static const _days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  // October 30, 2023
  static String full(DateTime d) => '${_months[d.month - 1]} ${d.day}, ${d.year}';

  // OCT
  static String shortMonth(DateTime d) =>
      _months[d.month - 1].substring(0, 3).toUpperCase();

  // MON
  static String shortDay(DateTime d) => _days[d.weekday - 1];

  // 2025-05-17
  static String numeric(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static bool sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
