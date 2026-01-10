enum Operation { sum, sub, mul, div }

class Question {
  final int left;
  final int right;
  final Operation type;
  final int answer;

  Question({required this.left, required this.right, required this.type})
    : answer = _calculateAnswer(left, right, type);

  static int _calculateAnswer(int a, int b, Operation type) {
    switch (type) {
      case Operation.sum:
        return a + b;
      case Operation.sub:
        return a - b;
      case Operation.mul:
        return a * b;
      case Operation.div:
        return a ~/ b; // división entera
    }
  }
}
