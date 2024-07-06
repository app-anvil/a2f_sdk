import 'package:meta/meta.dart';

import 'cache.dart';

abstract interface class ICachedItem<Value> {
  @protected
  abstract final SingletonCache<Value> cache;

  Value? get item;

  Value getOrThrow();
}

mixin CachedItem<Value> implements ICachedItem<Value> {
  @override
  final SingletonCache<Value> cache = SingletonCache();

  @override
  Value? get item => cache.item;

  @override
  Value getOrThrow() => cache.getOrThrow();
}
