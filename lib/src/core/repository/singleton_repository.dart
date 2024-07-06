import '../../../a2f_sdk.dart';

/// The abstraction of a repository that handles a single item.
abstract class SingletonRepository<Entity, State>
    extends BaseRepository<Entity, State> with CachedItem<Entity> {}
