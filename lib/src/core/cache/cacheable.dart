import 'package:meta/meta.dart';

import 'cache.dart';

/// The abstraction of a cache that handles a map of items of type [Value].
abstract interface class Cacheable<Key, Value> {
  @protected
  abstract final Cache<Key, Value> cache;

  List<Value> get items;
}
