import '../../../a2f_sdk.dart';

export 'base_repository.dart';
export 'singleton_repository.dart';
export 'state/state.dart';

/// The abstraction of the repository that handles a collection of items of type
/// [E]
///
/// [Key] is the type of the key of the cache. Typically is the id of the
/// entity [E].
abstract class Repository<Key, E, State> extends BaseRepository<E, State>
    with CachedCollectionMixin<Key, E> {}
