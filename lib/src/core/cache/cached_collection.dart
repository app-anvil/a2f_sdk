import 'package:meta/meta.dart';

import 'cache.dart';

abstract interface class ICachedCollection<Key, Value> {
  @protected
  Cache<Key, Value> get cache;

  List<Value> get items;

  Value operator [](Key key);

  Value? get(Key key, {Value Function()? orElse});

  Value getOrThrow(Key key);
}

/// The abstraction of a collection of items of type [Value] backed up by a
/// cache.
mixin CachedCollectionMixin<Key, Value>
    implements ICachedCollection<Key, Value> {
  @override
  final Cache<Key, Value> cache = Cache();

  @override
  List<Value> get items => cache.values;

  @override
  Value operator [](Key key) => cache.getOrThrow(key);

  @override
  Value? get(Key key, {Value Function()? orElse}) =>
      cache.get(key, orElse: orElse);

  @override
  Value getOrThrow(Key key) => cache.getOrThrow(key);
}
