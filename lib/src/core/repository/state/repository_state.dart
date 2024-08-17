import 'package:equatable/equatable.dart';

/// Parent class for the states of the repositories.
abstract class RepositoryState<Entity> extends Equatable {
  const RepositoryState();
}

/// State for when a collection of items is fetched.
class RepositoryCollectionFetched<Entity> extends RepositoryState<Entity> {
  const RepositoryCollectionFetched(this.items);

  final List<Entity> items;

  @override
  List<Object?> get props => [items];
}

/// State for when an item is fetched.
class RepositoryItemFetched<Entity> extends RepositoryState<Entity> {
  const RepositoryItemFetched(this.item);

  final Entity item;

  @override
  List<Object?> get props => [item];
}

/// State for when a new item is added to the repository.
class RepositoryItemAdded<Entity> extends RepositoryState<Entity> {
  const RepositoryItemAdded(this.item);

  final Entity item;

  @override
  List<Object?> get props => [item];
}

/// State for when an item is deleted from the repository.
class RepositoryItemDeleted<Entity> extends RepositoryState<Entity> {
  const RepositoryItemDeleted(this.item);

  final Entity item;

  @override
  List<Object?> get props => [item];
}

/// State for when an item is updated in the repository.
class RepositoryItemUpdated<Entity> extends RepositoryState<Entity> {
  const RepositoryItemUpdated(this.previousItem, this.updatedItem);

  /// Item before the update.
  ///
  /// It may be null if the item was not present in the repository.
  final Entity? previousItem;

  /// Item after the update.
  final Entity updatedItem;

  @override
  List<Object?> get props => [previousItem, updatedItem];
}
