import '../core.dart';

abstract base class InMemoryDataSource<Key, Value>
    with CachedCollectionMixin<Key, Value> {}
