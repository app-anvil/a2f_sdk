import 'package:equatable/equatable.dart';

/// Parent class for the states of the repositories.
abstract class RepositoryV2State<Entity> extends Equatable {
  const RepositoryV2State();

  @override
  List<Object?> get props => [];
}

/// State for when a collection of items is being fetched.
class RepoV2CollectionFetchInProgress<Entity>
    extends RepositoryV2State<Entity> {
  const RepoV2CollectionFetchInProgress();

  @override
  String toString() => '$RepoV2CollectionFetchInProgress { }';
}

/// State for when a collection of items is fetched successfully.
class RepoV2CollectionFetchSuccess<Entity> extends RepositoryV2State<Entity> {
  const RepoV2CollectionFetchSuccess(this.items);

  final List<Entity> items;

  @override
  List<Object?> get props => [items];

  @override
  String toString() =>
      '$RepoV2CollectionFetchSuccess { items: ${items.length} }';
}

/// State for when a collection of items is fetched with an error.
class RepoV2CollectionFetchError<Entity, Error>
    extends RepositoryV2State<Entity> {
  const RepoV2CollectionFetchError(this.error);

  final Error error;

  @override
  List<Object?> get props => [error];

  @override
  String toString() => '$RepoV2CollectionFetchError { error: $error }';
}

/// State for when an item is being fetched.
class RepoV2ItemFetchInProgress<Id, Entity> extends RepositoryV2State<Entity> {
  final Id id;

  const RepoV2ItemFetchInProgress(this.id);

  @override
  String toString() => '$RepoV2ItemFetchInProgress { id: $id }';

  @override
  List<Object?> get props => [id];
}

/// State for when an item is fetched successfully.
class RepoV2ItemFetchSuccess<Entity> extends RepositoryV2State<Entity> {
  const RepoV2ItemFetchSuccess(this.item);

  final Entity item;

  @override
  List<Object?> get props => [item];

  @override
  String toString() => '$RepoV2ItemFetchSuccess { item: $item }';
}

/// State for when an item is fetched with an error.
class RepoV2ItemFetchError<Id, Entity, Error>
    extends RepositoryV2State<Entity> {
  const RepoV2ItemFetchError({
    required this.id,
    required this.error,
  });

  final Id id;
  final Error error;

  @override
  List<Object?> get props => [error, id];

  @override
  String toString() => '$RepoV2ItemFetchError { id: $id, error: $error }';
}

/// State for when a new item is being added to the repository.
class RepoV2ItemAddInProgress<Entity> extends RepositoryV2State<Entity> {
  const RepoV2ItemAddInProgress(this.item);

  final Entity item;

  @override
  List<Object?> get props => [item];

  @override
  String toString() => '$RepoV2ItemAddInProgress { item: $item }';
}

/// State for when a new item is added to the repository.
class RepoV2ItemAddSuccess<Entity> extends RepositoryV2State<Entity> {
  const RepoV2ItemAddSuccess(this.item);

  final Entity item;

  @override
  List<Object?> get props => [item];

  @override
  String toString() => '$RepoV2ItemAddSuccess { item: $item }';
}

/// State for when a new item is added to the repository with an error.
class RepoV2ItemAddError<Id, Entity, Error> extends RepositoryV2State<Entity> {
  const RepoV2ItemAddError({
    required this.id,
    required this.error,
  });

  final Id id;
  final Error error;

  @override
  List<Object?> get props => [error, id];

  @override
  String toString() => '$RepoV2ItemAddError { id: $id, error: $error }';
}

/// State for when an item is being deleted from the repository.
class RepoV2ItemDeleteInProgress<Id, Entity> extends RepositoryV2State<Entity> {
  const RepoV2ItemDeleteInProgress(this.id);

  final Id id;

  @override
  List<Object?> get props => [id];

  @override
  String toString() => '$RepoV2ItemDeleteInProgress { id: $id }';
}

/// State for when an item is deleted from the repository.
class RepoV2ItemDeleteSuccess<Entity> extends RepositoryV2State<Entity> {
  const RepoV2ItemDeleteSuccess(this.item);

  final Entity item;

  @override
  List<Object?> get props => [item];

  @override
  String toString() => '$RepoV2ItemDeleteSuccess { item: $item }';
}

/// State for when an item is deleted from the repository with an error.
class RepoV2ItemDeleteError<Id, Entity, Error>
    extends RepositoryV2State<Entity> {
  const RepoV2ItemDeleteError({
    required this.id,
    required this.error,
  });

  final Id id;
  final Error error;

  @override
  List<Object?> get props => [error, id];

  @override
  String toString() => '$RepoV2ItemDeleteError { id: $id, error: $error }';
}

/// State for when an item is updated in the repository.
class RepoV2ItemUpdateInProgress<Id, Entity> extends RepositoryV2State<Entity> {
  const RepoV2ItemUpdateInProgress(this.id);

  final Id id;

  @override
  List<Object?> get props => [id];

  @override
  String toString() => '$RepoV2ItemUpdateInProgress { id: $id }';
}

/// State for when an item is updated in the repository.
class RepoV2ItemUpdateSuccess<Entity> extends RepositoryV2State<Entity> {
  const RepoV2ItemUpdateSuccess(this.previous, this.updated);

  final Entity previous;
  final Entity updated;

  @override
  List<Object?> get props => [previous, updated];

  @override
  String toString() =>
      '$RepoV2ItemUpdateSuccess { previous: $previous, updated: $updated }';
}
