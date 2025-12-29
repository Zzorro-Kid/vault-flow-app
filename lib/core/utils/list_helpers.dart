class ListHelpers {
  static List<T> filterByType<T>({
    required List<T> items,
    required String type,
    required String Function(T) getType,
  }) {
    return items.where((item) => getType(item) == type).toList();
  }
}
