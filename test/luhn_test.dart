import 'package:luhn_algorithm/luhn_algorithm.dart';
import 'package:test/test.dart';

// ignore_for_file:lines_longer_than_80_chars

void main() {
  group('Luhn generate', () {
    test('should throw an exception if control digit is not in format', () {
      expect(
        () => Luhn.generate(format: ''),
        throwsA(isA<InvalidFormatException>()),
      );
      expect(() => Luhn.generate(format: 'x'), throwsA(isA<InvalidFormatException>()));
      expect(() => Luhn.generate(format: 'xxxxxx-xxx'), throwsA(isA<InvalidFormatException>()));
    });

    test('should throw an exception if control digit is at the end of the format', () {
      expect(() => Luhn.generate(format: 'cx'), throwsA(isA<InvalidFormatException>()));
      expect(() => Luhn.generate(format: 'xxcxxxx-xxx'), throwsA(isA<InvalidFormatException>()));
      expect(() => Luhn.generate(format: 'cxxcxxxx-xxx'), throwsA(isA<InvalidFormatException>()));
    });

    test('should return the correct amount of items', () {
      expect(Luhn.generate(n: 1).length, 1);
      expect(Luhn.generate(n: 10).length, 10);
      expect(Luhn.generate(n: 100).length, 100);
    });

    test('should match the set format', () {
      var format = 'xc';
      var regExp = RegExp(r'^[0-9]{2}$');
      expect(regExp.hasMatch(Luhn.generate(format: format, n: 1).first), true);

      format = 'xxxx-xxxx-xc';
      regExp = RegExp(r'^[0-9]{4}-[0-9]{4}-[0-9]{2}$');
      expect(regExp.hasMatch(Luhn.generate(format: format, n: 10).last), true);

      format = 'zxxxx-zzxxxx#zzzxc';
      regExp = RegExp(r'^z[0-9]{4}-zz[0-9]{4}#zzz[0-9]{2}$');
      expect(regExp.hasMatch(Luhn.generate(format: format).first), true);
    });
  });

  group('Luhn generateList', () {
    test('should throw an exception if control digit is not in format', () {
      expect(() => Luhn.generateList(format: ''), throwsA(isA<InvalidFormatException>()));
      expect(() => Luhn.generateList(format: 'x'), throwsA(isA<InvalidFormatException>()));
      expect(() => Luhn.generateList(format: 'xxxxxx/xxx'), throwsA(isA<InvalidFormatException>()));
    });

    test('should throw an exception if control digit is at the end of the format', () {
      expect(() => Luhn.generateList(format: 'cx'), throwsA(isA<InvalidFormatException>()));
      expect(() => Luhn.generateList(format: 'xxcxxxx-xxx-'), throwsA(isA<InvalidFormatException>()));
      expect(() => Luhn.generateList(format: 'cxxcxxxx-xxx-'), throwsA(isA<InvalidFormatException>()));
    });

    test('should return the correct amount of items', () {
      expect(Luhn.generateList(n: 2).length, 2);
      expect(Luhn.generateList(n: 9).length, 9);
      expect(Luhn.generateList(n: 999).length, 999);
    });

    test('should match the set format', () {
      var format = r'x$c';
      var regExp = RegExp(r'^[0-9]\$[0-9]$');
      expect(regExp.hasMatch(Luhn.generateList(format: format).first), true);

      format = '123456xc';
      regExp = RegExp(r'^123456[0-9]{2}$');
      expect(regExp.hasMatch(Luhn.generateList(format: format, n: 10).last), true);
    });
  });

  group('Luhn checksum', () {
    test('should return correct control digit', () {
      expect(Luhn.checksum('1'), 8);
      expect(Luhn.checksum('1234567890'), 3);
      expect(Luhn.checksum('938207423894723'), 2);
      expect(Luhn.checksum('1-2-3-4'), 4);
      expect(Luhn.checksum('1#2#3#4'), 4);
      expect(Luhn.checksum('12-23-34-45-56-67-78-89-90'), 2);
    });
  });

  group('Luhn validate', () {
    test('should return false if value is null', () {
      expect(Luhn.validate(null), false);
    });

    test('should return false if value length is 2 chars or less', () {
      expect(Luhn.validate(''), false);
      expect(Luhn.validate('1'), false);
    });

    test('should return false if the value is not correct', () {
      expect(Luhn.validate('11'), false);
      expect(Luhn.validate('12345'), false);
      expect(Luhn.validate('123'), false);
      expect(Luhn.validate('4748192090227444'), false);
    });

    test('should return true if the value is correct', () {
      expect(Luhn.validate('4748192090227442'), true);
      expect(Luhn.validate('4748-1920-9022-7442'), true);
      expect(Luhn.validate('4748#1920#9022#7442'), true);
    });
  });
}
