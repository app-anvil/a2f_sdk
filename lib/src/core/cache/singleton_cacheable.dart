import 'package:meta/meta.dart';

import 'cache.dart';

/// The abstraction of a cache that handles only one item of type [O].
abstract interface class SingletonCacheable<O> {
  @protected
  abstract final SingletonCache<O> cache;

  O? get item;
}
