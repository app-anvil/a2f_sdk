import '../core.dart';

abstract class InMemorySingletonDataSource<Key, Value>
    with CachedItem<Value> {}
