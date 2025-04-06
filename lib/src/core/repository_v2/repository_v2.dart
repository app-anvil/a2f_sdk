import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_umpteenth_logger/the_umpteenth_logger.dart';

part '_bloc.dart';

typedef A2EventHandler<R, Event, State> = FutureOr<R> Function(
  Event event,
  Emitter<State> emit,
);

class RepositoryV2<Key, Entity, Event, State> with LoggerMixin {
  @protected
  Map<Key, Entity> cache = {};

  final bloc = _RepoBloc<dynamic, Event, State>();
  final _handlers = <A2EventHandler<dynamic, Event, State?>>[];

  RepositoryV2();

  void register() {
    bloc
      ..on<_SequentialBlocEvent<dynamic, Event, State>>(
        (event, emit) async {
          dynamic result;
          try {
            for (final handler in _handlers) {
              final result = await handler(event.repoEvent, emit);
              if (result != null) {
                break;
              }
            }
            event.onSuccess?.call(result);
          } catch (e, s) {
            event.onError?.call(e, s);
          }
        },
        transformer: sequential(),
      )
      ..on<_ConcurrentBlocEvent<dynamic, Event, State>>(
        (event, emit) async {
          dynamic result;
          try {
            for (final handler in _handlers) {
              final result = await handler(event.repoEvent, emit);
              if (result != null) {
                break;
              }
            }
            event.onSuccess?.call(result);
          } catch (e, s) {
            event.onError?.call(e, s);
          }
        },
        transformer: concurrent(),
      );
  }

  void on<E extends Event, R>(A2EventHandler<R, E, State?> handler) =>
      _handlers.add((event, emit) async {
        if (event is E) {
          return await handler(event, emit);
        }
        return null;
      });

  void add(
    Event event, {
    RepositoryV2EventOnSuccess<dynamic>? onSuccess,
    RepositoryV2EventOnError? onError,
  }) =>
      addSequential(event, onSuccess: onSuccess, onError: onError);

  void addSequential<R>(
    Event event, {
    RepositoryV2EventOnSuccess<R>? onSuccess,
    RepositoryV2EventOnError? onError,
  }) =>
      bloc.add(
        _SequentialBlocEvent<R, Event, State>(
          event,
          onSuccess: onSuccess,
          onError: onError,
        ),
      );

  void addConcurrent<R>(
    Event event, {
    RepositoryV2EventOnSuccess<R>? onSuccess,
    RepositoryV2EventOnError? onError,
  }) =>
      bloc.add(
        _ConcurrentBlocEvent<R, Event, State>(
          event,
          onSuccess: onSuccess,
          onError: onError,
        ),
      );

  Future<R> addSequentialAndWait<R>(Event event) async {
    final completer = Completer<R>();
    addSequential(
      event,
      onError: completer.completeError,
      onSuccess: completer.complete,
    );
    return completer.future;
  }

  Future<R> addConcurrentAndWait<R>(Event event) async {
    final completer = Completer<R>();
    addConcurrent(
      event,
      onError: completer.completeError,
      onSuccess: completer.complete,
    );
    return completer.future;
  }

  void close() => bloc.close();

  List<Entity> get values => List.unmodifiable(cache.values);

  List<Key> get keys => List.unmodifiable(cache.keys);

  Map<Key, Entity> get items => Map.unmodifiable(cache);

  /// Get the item by [key] if exists, otherwise returns null.
  ///
  /// If [orElse] is provided, it will be called and its result will be returned
  /// if the item does not exist.
  Entity? get(Key key, {Entity Function()? orElse}) {
    final item = cache[key];
    if (item != null) return item;
    if (orElse != null) return orElse();
    return null;
  }

  /// Returns the item by [key]. If it does not exist it throws a `ItemNotFound`
  /// exception.
  Entity getOrThrow(Key key) => get(
        key,
        orElse: () => throw ArgumentError.value(
          key,
          'key',
          'Item with key $key not found.',
        ),
      )!;

  /// Listens the stream of states.
  @nonVirtual
  StreamSubscription<State> listen(
    void Function(State state) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      bloc.stream.where((state) => state != null).cast<State>().listen(
            (value) => onData(value),
            onError: onError,
            onDone: onDone,
            cancelOnError: cancelOnError,
          );
}
