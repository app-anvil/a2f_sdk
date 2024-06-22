import '../core.dart';

abstract interface class InMemorySingletonDataSource<Key, Value>
    implements SingletonCacheable<Value> {}
