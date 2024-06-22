import '../core.dart';

abstract interface class InMemoryDataSource<Key, Value>
    implements Cacheable<Key, Value> {}
