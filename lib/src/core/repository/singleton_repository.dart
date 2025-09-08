import '../../../a2f_sdk.dart';

/// The abstraction of a repository that handles a single item.
abstract class SingletonRepository<E, State> extends BaseRepository<E, State>
    with CachedItem<E> {}
