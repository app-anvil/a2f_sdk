import 'package:meta/meta.dart';

import 'cache.dart';

abstract interface class ICachedItem<Value> {
  @protected
  abstract final SingletonCache<Value> cache;

  Value? get item;
}

base mixin CachedItem<Value> implements ICachedItem<Value> {
  @override
  final SingletonCache<Value> cache = SingletonCache();

  @override
  Value? get item => cache.item;
}
