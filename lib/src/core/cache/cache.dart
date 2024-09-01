import 'immutable_cache.dart';

export 'cached_collection.dart';
export 'cached_item.dart';
export 'immutable_cache.dart';
export 'singleton_cache.dart';

/// {@template cache}
/// This class stores a collection of key/value pairs in memory.
/// The [Key] type is used as a key in the inner map.
/// {@endtemplate}
class Cache<Key, Value> {
  final _items = <Key, Value>{};

  /// Creates a new instance of [Cache].
  Cache();

  /// Creates a new instance of [Cache] from another [Cache].
  Cache.from(Cache<Key, Value> cache) {
    _items.addAll(cache._items);
  }

  /// Creates a new instance of [Cache] from a [Map].
  Cache.fromMap(Map<Key, Value> items) {
    _items.addAll(items);
  }

  Cache<Key, Value> get immutable => ImmutableCache.from(this);

  /// Gets all the keys of the cache.
  List<Key> get keys => [..._items.keys];

  /// Gets all the values of the cache.
  List<Value> get values => [..._items.values];

  /// Gets all the key/value pairs of the cache.
  Map<Key, Value> get items => {..._items};

  /// Gets all the key/value pairs of the cache as a list of [MapEntry].
  List<MapEntry<Key, Value>> get entries => _items.entries.toList();

  /// Saves the [value] to this map
  void save(Key key, Value value) {
    _items[key] = value;
  }

  /// Saves all key/value pairs of [items] to this map.
  void saveAll(Map<Key, Value> items) {
    _items.addAll(items);
  }

  /// Get the item by [key] if exists, otherwise returns null.
  ///
  /// If [orElse] is provided, it will be called and its result will be returned
  /// if the item does not exist.
  Value? get(Key key, {Value Function()? orElse}) {
    final item = _items[key];
    if (item != null) return item;
    if (orElse != null) return orElse();
    return null;
  }

  /// Returns the item by [key]. If it does not exist it throws a `ItemNotFound`
  /// exception.
  Value getOrThrow(Key key) => get(
        key,
        orElse: () => throw ArgumentError.value(
          key,
          'key',
          'Item with key $key not found.',
        ),
      )!;

  /// Deletes the item with [key] from the map.
  void delete(Key key) {
    _items.remove(key);
  }

  /// Deletes all key/value pairs of [items] from the map.
  void clear() {
    _items.clear();
  }

  /// Deletes all items with key in [keys] from the map.
  void deleteAll(Iterable<Key> keys) {
    for (final key in keys) {
      _items.remove(key);
    }
  }

  /// Replaces all items in the cache with the items in [items].
  void replaceAll(Map<Key, Value> items) {
    _items
      ..clear()
      ..addAll(items);
  }
}
