import 'package:luhn_algorithm/luhn_algorithm.dart';

// ignore_for_file: avoid_print

void main() {
  // Function generate

  final iterator = Luhn.generate(n: 3);
  for (final value in iterator) {
    print('Generated value is $value');
  }
  // Generated value is 91207
  // Generated value is 25643
  // Generated value is 48322

  Luhn.generate(format: 'xxxx-xxxx-xxxx-xxxc', n: 10).forEach(print);
  // 8766-6207-9825-0454
  // 0748-6872-9179-2506
  // 7721-4655-2308-2418
  // 5357-3522-2909-5388
  // 1132-3019-6824-9848
  // 5293-2324-7757-8003
  // 9901-8998-8519-1219
  // 1899-7700-9488-9896
  // 0663-3751-6153-3629
  // 2410-2528-3254-5799

  // Function generateList

  Luhn.generateList(format: 'xxxx/xx/xx/xxc', n: 3).forEach(print);
  // 3326/95/78/028
  // 7705/37/94/556
  // 0775/73/88/967

  print(Luhn.generateList(format: 'xxc', n: 10));
  // [968, 075, 760, 497, 174, 463, 372, 133, 455, 836]

  // Function checksum

  final checksum = Luhn.checksum('1234');
  print(checksum);
  // 4

  // Function validate

  print(Luhn.validate('12344'));
  // true

  print(Luhn.validate('1234-1234-1234-1234'));
  // false
}
