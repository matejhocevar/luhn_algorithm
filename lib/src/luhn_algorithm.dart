import 'dart:math';

import 'package:luhn_algorithm/src/exceptions.dart';

// ignore_for_file:avoid_classes_with_only_static_members
// ignore_for_file:lines_longer_than_80_chars

/// Luhn algorithm implementation
class Luhn {
  /// Creates an iterable for [n] Luhn valid string items.
  ///
  /// ```
  ///   Luhn.generate(format: 'xxxx-xxxxxxx-xxxx', n: 10)
  /// ```
  ///
  /// The format of the generated items can be provided with [format] parameter,
  /// where in format:
  ///
  ///     - x = Random digit
  ///     - c = Control digit.
  ///
  /// Throws and [InvalidFormatException] if control digit is missing
  /// or not present at the end of the format. It will also throw and [InvalidFormatException]
  /// if the control digit is implemented on multiple places.
  ///
  /// Number of items can be provided with [n] parameter.
  static Iterable<String> generate({String format = 'xxxxc', int n = 5}) sync* {
    var items = n;
    if ('c'.allMatches(format).length != 1 ||
        format.indexOf('c') != format.length - 1) {
      throw InvalidFormatException(
        'Control digit (c) should be placed at the end of the format string',
      );
    }

    while (items > 0) {
      final payload = format.split('c')[0];
      final value = payload.replaceAllMapped('x', _replaceWithRandomDigit);
      final controlDigit = checksum(_removeNonDigits(value));
      yield '$value$controlDigit';
      items--;
    }
  }

  /// Generates list of [n] items.
  /// ```
  ///   Luhn.generateList(format: 'xxxx-xxxxxxx-xxxx', n: 10)
  /// ```
  /// Items are Luhn valid strings based on this provided [format].
  static List<String> generateList({String format = 'xxxxc', int n = 1}) {
    return generate(format: format, n: n).toList();
  }

  /// Returns a checksum of provided [value]
  ///
  /// ```
  /// Luhn.checksum('1234') == 4
  /// ```
  static int checksum(String value) {
    final clean = _removeNonDigits(value);
    final sum = _compute(clean);
    return (10 - (sum % 10)) % 10;
  }

  /// Validates whether provided [value] is Luhn valid
  ///
  /// ```
  /// Luhn.validate('12344') == true
  /// ```
  static bool validate(String? value) {
    if (value == null) {
      return false;
    }

    final clean = _removeNonDigits(value);
    if (clean.length < 2) {
      return false;
    }

    return _compute(clean, includesCheckDigit: true) % 10 == 0;
  }

  /// Main Luhn algorithm
  static int _compute(String value, {bool includesCheckDigit = false}) {
    var sum = 0;

    /// If last char is checksum digit we skip first multiplication
    var isDouble = !includesCheckDigit;

    /// We want to double every second digit
    for (var i = value.length - 1; i >= 0; i--) {
      final digit = value.codeUnitAt(i) - 48;

      if (isDouble) {
        final doubled = digit * 2;
        if (doubled > 9) {
          /// Same as we would count digits together
          ///   doubled = 16 -> 1 + 6 = 7
          ///   doubled = 16 -> 16 - 9 = 7
          sum += doubled - 9;
        } else {
          sum += doubled;
        }
      } else {
        sum += digit;
      }

      /// Double the value of every second digit
      isDouble = !isDouble;
    }

    return sum;
  }

  // Helpers

  /// Remove all non-digit chars from the string
  static String _removeNonDigits(String str) {
    final nonDigit = RegExp('[^0-9]');
    return str.replaceAll(nonDigit, '');
  }

  /// Replaces all matches with a random digit
  static String _replaceWithRandomDigit(Match _) =>
      '${Random.secure().nextInt(10)}';
}
