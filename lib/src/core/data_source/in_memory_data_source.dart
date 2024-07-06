import '../core.dart';

abstract class InMemoryDataSource<Key, Value>
    with CachedCollectionMixin<Key, Value> {}
