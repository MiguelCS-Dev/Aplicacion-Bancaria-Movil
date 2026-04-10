import 'dart:math';

class AccountNumberGenerator {
  static String generate() {
    final random = Random();
    return "4${List.generate(15, (_) => random.nextInt(10)).join()}";
  }
}
