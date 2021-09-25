class Utils {
  /// Convert a number to its english representations.
  /// E.g. 1 becomes one.
  /// E.g 2 becomes two.
  static String numberToWord(int number) {
    if (number >= 10) {
      return '$number';
    }

    var list = [
      'zero',
      'one',
      'two',
      'three',
      'four',
      'five',
      'six',
      'seven',
      'eight',
      'nine',
      'ten',
    ];

    return list[number];
  }
}
