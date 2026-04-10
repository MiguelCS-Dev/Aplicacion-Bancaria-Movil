class AccountNumberFormatter {
  static String format(String number) {
    if (number.isEmpty) return '';

    final buffer = StringBuffer();

    for (int i = 0; i < number.length; i++) {
      buffer.write(number[i]);

      if ((i + 1) % 4 == 0 && i != number.length - 1) {
        buffer.write(' ');
      }
    }

    return buffer.toString();
  }
}
