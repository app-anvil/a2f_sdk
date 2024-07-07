import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Short UUID', () {
    test('Generate a short UUID', () {
      final uuid = const Uuid().v4();
      final shortUuid = const UuidShortener.urlSafe().shorten(uuid);
      final result = const UuidShortener.urlSafe().toUuid(shortUuid);
      expect(result, uuid);
    });
  });
}
