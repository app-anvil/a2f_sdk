export 'cacheable.dart';
export 'singleton_cache.dart';
export 'singleton_cacheable.dart';

class ItemNotFound implements Exception {}

/// {@template cache}
/// This class stores a collection of key/value pairs in memory.
/// The [Key] type is used as a key in the inner map.
/// {@endtemplate}
class Cache<Key, Value> {
  late final _items = <Key, Value>{};

  List<Value> get items => [..._items.values];

  /// Saves the [value] to this map
  void save(Key key, Value value) {
    _items[key] = value;
  }

  /// Saves all key/value pairs of [items] to this map.
  void saveAll(Map<Key, Value> items) {
    _items.addAll(items);
  }

  /// Get the item by [key] if exists, otherwise returns null.
  Value? get(Key key) => _items[key];

  /// Returns the item by [key]. If it does not exist it throws a `ItemNotFound`
  /// exception.
  Value getOrThrow(Key key) {
    final item = _items[key];
    if (item == null) throw ItemNotFound();
    return item;
  }

  /// Updates the [value] to this map if exists. Otherwise his behavior is the
  /// same as save.
  void update(Key key, Value value) {
    _items[key] = value;
  }

  /// Deletes the item with [key] from the map.
  void delete(Key key) {
    _items.remove(key);
  }

  /// Deletes all key/value pairs of [items] from the map.
  void clear() {
    _items.clear();
  }
}
