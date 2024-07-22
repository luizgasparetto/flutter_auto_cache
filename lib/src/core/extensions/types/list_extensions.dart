extension SortListExtension<T extends Object> on List<T> {
  List<T> sorted(int Function(T a, T b) compare) {
    final sortedList = List<T>.from(this);
    sortedList.sort(compare);

    return sortedList;
  }
}

extension RemoveFirstListExtension<T extends Object> on List<T> {
  List<T> removeFirst() {
    final copyList = List<T>.from(this);

    if (this.isEmpty) return [];

    return copyList.sublist(1);
  }
}
