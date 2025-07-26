import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Unit Tests', () {
    test('Basic arithmetic test', () {
      expect(1 + 1, equals(2));
      expect(2 * 3, equals(6));
      expect(10 - 5, equals(5));
    });

    test('String operations test', () {
      expect('Hello'.length, equals(5));
      expect('Flutter'.toUpperCase(), equals('FLUTTER'));
      expect('Dart'.toLowerCase(), equals('dart'));
    });

    test('List operations test', () {
      final list = [1, 2, 3, 4, 5];
      expect(list.length, equals(5));
      expect(list.first, equals(1));
      expect(list.last, equals(5));
      expect(list.contains(3), isTrue);
      expect(list.contains(10), isFalse);
    });

    test('Map operations test', () {
      final map = {'name': 'Flutter', 'version': '3.32.4'};
      expect(map.length, equals(2));
      expect(map['name'], equals('Flutter'));
      expect(map['version'], equals('3.32.4'));
      expect(map.containsKey('name'), isTrue);
      expect(map.containsKey('author'), isFalse);
    });
  });
} 