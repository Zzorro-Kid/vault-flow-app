enum PeriodType {
  day('day'),
  week('week'),
  month('month'),
  year('year');

  final String value;

  const PeriodType(this.value);

  static PeriodType fromString(String value) {
    return PeriodType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => PeriodType.month,
    );
  }
}
