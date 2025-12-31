class PeriodFormatter {
  static String format(String period) {
    return switch (period) {
      'day' => 'Today',
      'week' => 'This Week',
      'month' => 'This Month',
      'year' => 'This Year',
      _ => 'This Month',
    };
  }
}
