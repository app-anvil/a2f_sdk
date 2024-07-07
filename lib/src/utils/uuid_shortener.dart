const _kNumbers = '0123456789';
const _kLcLetters = 'abcdefghijklmnopqrstuvwxyz';
const _kUcLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
// const _kSymbols = '-.~_';
const _kUrlSafeAlphabet = _kNumbers + _kLcLetters + _kUcLetters;

extension _ToBigIntExtension on int {
  BigInt get asBigInt => BigInt.from(this);
}

/// Utility class to shorten UUIDs to a string in a custom alphabet and vice
/// versa.
///
/// [UuidShortener.urlSafe] uses a URL-safe alphabet. It can be used to beautify
/// UUIDs in URLs.
class UuidShortener {
  final String alphabet;

  const UuidShortener({required this.alphabet});

  const UuidShortener.urlSafe() : alphabet = _kUrlSafeAlphabet;

  int get _base => alphabet.length;

  /// Shortens a UUID to a string in [alphabet].
  String shorten(String uuid) {
    final base10 = BigInt.parse(uuid.replaceAll('-', ''), radix: 16);
    return _toAlphabetString(base10);
  }

  /// Converts a string in [alphabet] to a UUID.
  String toUuid(String shortString) {
    final base10 = _fromAlphabetString(shortString);
    final hex = base10.toRadixString(16);
    final hexUuid = hex.padLeft(32, '0');
    final uuid = hexUuid.substring(0, 8) +
        '-' +
        hexUuid.substring(8, 12) +
        '-' +
        hexUuid.substring(12, 16) +
        '-' +
        hexUuid.substring(16, 20) +
        '-' +
        hexUuid.substring(20);
    return uuid;
  }

  /// Converts a BigInt to a string in [alphabet].
  String _toAlphabetString(BigInt number) {
    if (number == BigInt.zero) return alphabet[0];
    var result = '';
    final base = _base.asBigInt;
    var n = number;
    while (n > BigInt.zero) {
      result = alphabet[(n % base).toInt()] + result;
      n ~/= base;
    }
    return result;
  }

  /// Converts a string in [alphabet] to a BigInt.
  BigInt _fromAlphabetString(String str) {
    var result = BigInt.zero;
    final base = _base.asBigInt;
    for (var i = 0; i < str.length; i++) {
      result = result * base + alphabet.indexOf(str[i]).asBigInt;
    }
    return result;
  }
}
