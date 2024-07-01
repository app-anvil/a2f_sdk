import '../../../a2f_sdk.dart';

/// A common parent for entities.
abstract class Entity with ModelToStringMixin, EquatableMixin {
  const Entity();
}
