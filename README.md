# Luhn algorithm

[![Dart CI](https://github.com/matejhocevar/luhn_algorithm/actions/workflows/dart-ci.yml/badge.svg)](https://github.com/matejhocevar/luhn_algorithm/actions/workflows/dart-ci.yml)
[![codecov](https://codecov.io/gh/matejhocevar/luhn_algorithm/branch/main/graph/badge.svg?token=J1SUECF4ZA)](https://codecov.io/gh/matejhocevar/luhn_algorithm)
[![License: MIT][license_badge]][license_link]

Luhn algorithm is an implementation of the famous Luhn algorithm in Dart. Generate, checksum and validate.

Implementation of this package support:

- ⚙️ Generation of values based on your format. Returns as list or iterable.
- 👌 Computing checksum from provided payload.
- 🧪 Validation of existing value.

## Background

The Luhn algorithm, also known as the modulus 10 or mod 10 algorithm, is a simple checksum formula 
used to validate a variety of identification numbers, such as credit card numbers, IMEI numbers, 
Canadian Social Insurance Numbers. The LUHN formula was created in the late 1960s by a group of mathematicians.
Shortly thereafter, credit card companies adopted it. Because the algorithm is in the public domain,
it can be used by anyone. Most credit cards and many government identification numbers
use the algorithm as a simple method of distinguishing valid numbers from mistyped or otherwise incorrect numbers.

It was designed to protect against accidental errors, not malicious attacks.

The algorithm will detect any single-digit error, as well as almost all transpositions of adjacent digits.
It will not, however, detect transposition of the two-digit sequence 09 to 90 (or vice versa).
It will detect most of the possible twin errors (it will not detect 22 <-> 55, 33 <-> 66 or 44 <-> 77).

Good for:

- ✅ Detecting a character that is misread or badly written
- ✅ Presence or absence of leading zeros at the beginning of the number does not modify the checksum
- ✅ Used by MasterCard, American Express, Visa and others

Not good for:

- ❌ Does not detect certain permutations of digits. E.g. `09` <-> `90` (identical checksum)
- ❌ Failure to detect double errors. E.g. `22` <-> `55`

## Quick start

## Install

```bash
dart pub add luhn_algorithm
```

or add manually add it to pubspec.yaml

```bash
dependencies:
  luhn_algorithm: ^1.0.0
```

## Usage

### Generate
This package contains a function for generating valid Luhn values. You can provide your own formatting, non-digit characters will be ignored.

This is specially useful for testing.

---

#### Generate as iterable

You can finetune the results by specifying the following parameters:

- `format`: specified format, where `x` represents random digit (0-9) and `c` control digit which (!) must be always at the last place in the format.
- `n`: number of returned values

All other character specified in the `format` parameter will be remain there but are going to be ignored in the algorithm compute. 

```dart
import 'package:luhn_algorithm/luhn_algorithm.dart';

var iterator = Luhn.generate(n: 3);
for (String value in iterator) {
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
```

---

#### Generate as list

This function takes the same parameters and `generate` function.

```dart
import 'package:luhn_algorithm/luhn_algorithm.dart';

Luhn.generateList(format: 'xxxx/xx/xx/xxc', n: 3).forEach(print);
// 3326/95/78/028
// 7705/37/94/556
// 0775/73/88/967

print(Luhn.generateList(format: 'xxc', n: 10));
// [968, 075, 760, 497, 174, 463, 372, 133, 455, 836]
```

---

### Checksum
To get checksum of your value use `checksum` function.

```dart
final var checksum = Luhn.checksum('1234');
print(checksum);
// 4
```

---

### Validate
To validate existing value us static method `Luhn.validate`. Code assumes that the last character of
the string is a control digit.

```dart
print(Luhn.validate('12344'));
// true

print(Luhn.validate('1234-1234-1234-1234'));
// false
```

## Special thanks to

- [Hans Peter Luhn](https://en.wikipedia.org/wiki/Hans_Peter_Luhn)

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://github.com/matejhocevar/luhn_algorithm/LICENSE
