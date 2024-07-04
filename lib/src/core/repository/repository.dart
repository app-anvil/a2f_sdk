import '../../../a2f_sdk.dart';

export 'base_repository.dart';
export 'singleton_repository.dart';

/// The abstraction of the repository that handles a collection of items of type
/// [Entity]
///
/// [Key] is the type of the key of the cache. Typically is the id of the
/// [Entity].
abstract base class Repository<Key, Entity, State>
    extends BaseRepository<Entity, State>
    with CachedCollectionMixin<Key, Entity> {}
