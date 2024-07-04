import '../../../a2f_sdk.dart';

/// The abstraction of the base repository.
///
/// All repositories that extend this class have a stream listenable from
/// outside.
///
/// Usually you want to use a [Repository] or [SingletonRepository] instead of
/// this class.
abstract class BaseRepository<Entity, State>
    with LoggerMixin, ObservableMixin<State> {}
