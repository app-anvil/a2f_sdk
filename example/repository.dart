import 'dart:async';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:equatable/equatable.dart';

typedef TodoId = int;

class TodoEntity {
  TodoEntity({required this.id, required this.name});

  final TodoId id;
  final String name;

  @override
  String toString() {
    return 'TodoEntity('
        'id: $id, name: $name'
        ')';
  }
}

sealed class TodoRepositoryState extends Equatable {
  const TodoRepositoryState();

  @override
  bool? get stringify => false;
}

final class TodoRepositoryTodoAdded extends TodoRepositoryState {
  const TodoRepositoryTodoAdded(this.todo);

  final TodoEntity todo;

  @override
  List<Object?> get props => [todo];
}

final class TodoRepositoryTodoFetched extends TodoRepositoryState {
  const TodoRepositoryTodoFetched(this.todos);

  final List<TodoEntity> todos;

  @override
  List<Object?> get props => [todos];
}

// ignore: one_member_abstracts
abstract interface class TodoDataSource {
  FutureOr<List<TodoEntity>> fetch();
}

final class TodoInMemoryDataSource
    extends InMemoryDataSource<TodoId, TodoEntity> implements TodoDataSource {
  TodoInMemoryDataSource() {
    cache.saveAll({
      1: TodoEntity(id: 1, name: 'Foo'),
      2: TodoEntity(id: 2, name: 'Bar'),
    });
  }

  @override
  FutureOr<List<TodoEntity>> fetch() {
    return items;
  }
}

final class TodoRepository
    extends Repository<TodoId, TodoEntity, TodoRepositoryState> {
  TodoRepository(this._dataSource);

  final TodoDataSource _dataSource;

  /// The stream controller of repository's state.
  ///
  /// It can be for example a `PublishSubject<S>` (aka StreamController<S>),
  /// or a `BehaviorSubject<S>`: it captures the latest item that has been added
  /// to the controller, and emits that as the first item to any new listener.
  // final _statesStreamController = PublishSubject<TodoRepositoryState>();

  // @override
  // Stream<TodoRepositoryState> get states => _statesStreamController.stream;

  FutureOr<List<TodoEntity>> fetch() async {
    final items = await _dataSource.fetch();
    cache.saveAll({for (final i in items) i.id: i});
    emit(TodoRepositoryTodoFetched(items));
    return items;
  }
}

final class TodoSingletonRepository
    extends SingletonRepository<TodoEntity, TodoRepositoryState> {
  TodoSingletonRepository(this._dataSource);

  // ignore: unused_field
  final TodoDataSource _dataSource;
}
