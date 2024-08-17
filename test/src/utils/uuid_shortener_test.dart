import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

const _invalidShort = r'/&^/*$%?^8%$';

void main() {
  group('UuidShortener.shorten', () {
    test('should generate a short UUID', () {
      final uuid = const Uuid().v4();
      final shortUuid = const UuidShortener.urlSafe().shorten(uuid);
      final result = const UuidShortener.urlSafe().toUuid(shortUuid);
      expect(result, uuid);
    });

    test('should throw an error for an invalid UUID', () {
      const uuid = 'invalid-uuid';
      expect(
        () => const UuidShortener.urlSafe().shorten(uuid),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('UuidShortener.isValidShort', () {
    test('should return true if the string is in the alphabet', () {
      final alphabet = const UuidShortener.urlSafe().alphabet;
      final result = const UuidShortener.urlSafe().isValidShort(alphabet);
      expect(result, isTrue);
    });

    test('should return false if the string is not in the alphabet', () {
      final result = const UuidShortener.urlSafe().isValidShort(_invalidShort);
      expect(result, isFalse);
    });
  });

  group('UuidShortener.toUuid', () {
    test('should throw an error for an invalid short string', () {
      expect(
        () => const UuidShortener.urlSafe().toUuid(_invalidShort),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('UuidShortener.toUuidIfNotAlready', () {
    test('should return the input if it is already a UUID', () {
      final uuid = const Uuid().v4();
      final result = const UuidShortener.urlSafe().toUuidIfNotAlready(uuid);
      expect(result, uuid);
    });

    test('should convert the input to a UUID if it is not already', () {
      final uuid = const Uuid().v4();
      final shortUuid = const UuidShortener.urlSafe().shorten(uuid);
      final result =
          const UuidShortener.urlSafe().toUuidIfNotAlready(shortUuid);
      expect(result, uuid);
    });
  });

  group('UuidShortener.shortenIfNotAlready', () {
    test('should return the input if it is already a short UUID', () {
      final shortUuid =
          const UuidShortener.urlSafe().shorten(const Uuid().v4());
      final result =
          const UuidShortener.urlSafe().shortenIfNotAlready(shortUuid);
      expect(result, shortUuid);
    });

    test('should convert the input to a short UUID if it is not already', () {
      final uuid = const Uuid().v4();
      final shortUuid = const UuidShortener.urlSafe().shorten(uuid);
      final result = const UuidShortener.urlSafe().shortenIfNotAlready(uuid);
      expect(result, shortUuid);
    });

    test('should throw an error for an invalid short string', () {
      expect(
        () => const UuidShortener.urlSafe().shortenIfNotAlready(_invalidShort),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
