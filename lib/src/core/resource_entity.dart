import 'uniquely_identifiable_entity.dart';

/// A common parent for entities.
abstract interface class ResourceEntity implements UniquelyIdentifiableEntity {
  /// When the entity was created.
  DateTime get createdAt;

  /// When the entity was last updated.
  DateTime? get updatedAt;
}
