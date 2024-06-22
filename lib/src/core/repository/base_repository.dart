import '../../../a2f_sdk.dart';

/// The abstraction of the base repository.
///
/// All repositories that extend this class have a stream listenable
/// from outside.
abstract class BaseRepository<Entity, State>
    with LoggerMixin, ObservableMixin<State> {}
