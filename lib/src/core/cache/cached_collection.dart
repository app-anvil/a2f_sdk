import 'package:meta/meta.dart';

import 'cache.dart';

abstract interface class ICachedCollection<Key, Value> {
  @protected
  Cache<Key, Value> get cache;

  List<Value> get items;
}

/// The abstraction of a collection of items of type [Value] backed up by a
/// cache.
base mixin CachedCollectionMixin<Key, Value>
    implements ICachedCollection<Key, Value> {
  @override
  final Cache<Key, Value> cache = Cache();

  @override
  List<Value> get items => cache.items;
}
