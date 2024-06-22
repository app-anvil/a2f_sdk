import 'package:meta/meta.dart';

import '../../../a2f_sdk.dart';

/// The abstraction of a repository that handles a single item.
abstract class SingletonRepository<Entity, State>
    extends BaseRepository<Entity, State> {
  @protected
  final SingletonCache<Entity> cache = SingletonCache();

  Entity? get item => cache.item;
}
