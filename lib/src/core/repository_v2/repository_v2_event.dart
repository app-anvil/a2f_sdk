import 'package:equatable/equatable.dart';

abstract class RepositoryV2Event<Entity> extends Equatable {
  const RepositoryV2Event();

  @override
  List<Object?> get props => [];
}

/// Event for when a collection of items is fetched.
class RepoV2CollectionFetched<Entity> extends RepositoryV2Event<Entity> {
  const RepoV2CollectionFetched();

  @override
  String toString() => '$RepoV2CollectionFetched { }';
}

/// Event for when an item is fetched.
class RepoV2ItemFetched<Id, Entity> extends RepositoryV2Event<Entity> {
  const RepoV2ItemFetched(this.id);

  final Id id;

  @override
  String toString() => '$RepoV2ItemFetched { id: $id }';

  @override
  List<Object?> get props => [id];
}

/// Event for when a new item is created in the repository.
class RepoV2ItemCreated<Id, Entity, Input> extends RepositoryV2Event<Entity> {
  const RepoV2ItemCreated(this.id, this.input);

  final Id id;
  final Input input;

  @override
  String toString() => '$RepoV2ItemCreated { id: $id, input: $input }';

  @override
  List<Object?> get props => [id, input];
}

/// Event for when an existing item is added in the repository.
class RepoV2ItemAdded<Entity> extends RepositoryV2Event<Entity> {
  const RepoV2ItemAdded(this.item);

  final Entity item;

  @override
  String toString() => '$RepoV2ItemAdded { item: $item }';

  @override
  List<Object?> get props => [item];
}

/// Event for when an item is updated.
class RepoV2ItemUpdated<Id, Entity, Input> extends RepositoryV2Event<Entity> {
  const RepoV2ItemUpdated(this.id, this.input);

  final Id id;
  final Input input;

  @override
  String toString() => '$RepoV2ItemUpdated { id: $id, input: $input }';

  @override
  List<Object?> get props => [id, input];
}

/// Event for when an item is deleted.
class RepoV2ItemDeleted<Id, Entity> extends RepositoryV2Event<Entity> {
  const RepoV2ItemDeleted(this.id);

  final Id id;

  @override
  String toString() => '$RepoV2ItemDeleted { id: $id }';

  @override
  List<Object?> get props => [id];
}
