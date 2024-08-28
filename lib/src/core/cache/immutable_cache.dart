import 'cache.dart';

/// {@template immutable_cache}
/// An immutable [Cache].
/// {@endtemplate}
class ImmutableCache<Key, Value> extends Cache<Key, Value> {
  /// Creates a new instance of [Cache].
  ImmutableCache.from(super.cache) : super.from();

  /// Creates a new instance of [Cache] from a [Map].
  ImmutableCache.fromMap(super.items) : super.fromMap();

  @override
  void clear() => throw UnsupportedError('This cache is immutable.');

  @override
  void delete(Key key) => throw UnsupportedError('This cache is immutable.');

  @override
  void deleteAll(Iterable<Key> keys) =>
      throw UnsupportedError('This cache is immutable.');

  @override
  void replaceAll(Map<Key, Value> items) =>
      throw UnsupportedError('This cache is immutable.');

  @override
  void save(Key key, Value value) =>
      throw UnsupportedError('This cache is immutable.');

  @override
  void saveAll(Map<Key, Value> items) =>
      throw UnsupportedError('This cache is immutable.');
}
