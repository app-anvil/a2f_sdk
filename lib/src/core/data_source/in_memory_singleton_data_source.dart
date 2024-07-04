import '../core.dart';

abstract base class InMemorySingletonDataSource<Key, Value>
    with CachedItem<Value> {}
