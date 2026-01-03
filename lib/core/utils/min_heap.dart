class MinHeap<T> {
  final List<T> _heap = [];
  final int Function(T a, T b) compare;
  final int maxSize;

  MinHeap({required this.compare, this.maxSize = 10});

  void add(T value) {
    if (_heap.length < maxSize) {
      _heap.add(value);
      _bubbleUp(_heap.length - 1);
    } else if (compare(value, _heap[0]) > 0) {
      _heap[0] = value;
      _bubbleDown(0);
    }
  }

  List<T> toList() {
    final sorted = List<T>.from(_heap)..sort(compare);
    return sorted;
  }

  int get length => _heap.length;

  bool get isEmpty => _heap.isEmpty;

  bool get isNotEmpty => _heap.isNotEmpty;

  void _bubbleUp(int index) {
    while (index > 0) {
      final parentIndex = (index - 1) ~/ 2;
      if (compare(_heap[index], _heap[parentIndex]) >= 0) break;
      _swap(index, parentIndex);
      index = parentIndex;
    }
  }

  void _bubbleDown(int index) {
    final length = _heap.length;
    while (true) {
      var smallest = index;
      final leftChild = 2 * index + 1;
      final rightChild = 2 * index + 2;

      if (leftChild < length &&
          compare(_heap[leftChild], _heap[smallest]) < 0) {
        smallest = leftChild;
      }
      if (rightChild < length &&
          compare(_heap[rightChild], _heap[smallest]) < 0) {
        smallest = rightChild;
      }
      if (smallest == index) break;
      _swap(index, smallest);
      index = smallest;
    }
  }

  void _swap(int i, int j) {
    final temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }
}
