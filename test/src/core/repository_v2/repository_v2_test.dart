import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

class _Item {
  const _Item(this.id, this.value);

  final String id;
  final int value;

  _Item copyWith({String? id, int? value}) {
    return _Item(id ?? this.id, value ?? this.value);
  }
}

Future<void> _wait([int ms = 2000]) =>
    Future.delayed(Duration(milliseconds: ms));

Map<String, _Item> _generate([int count = 100]) => Map.fromEntries(
      List.generate(count, (_) => const Uuid().v4()).map(
        (id) => MapEntry(
          id,
          _Item(id, 0),
        ),
      ),
    );

class _Repo extends Repository<String, _Item, RepositoryState<_Item>> {
  _Repo() : super();

  Future<Map<String, _Item>> fetch() async {
    cache
      ..clear()
      ..saveAll(_generate());
    emit(RepositoryCollectionFetched(cache.values.toList()));
    return cache.items;
  }

  Future<_Item> update(String id, int value) async {
    await _wait();
    final item = cache.getOrThrow(id);
    final updatedItem = item.copyWith(value: value);
    cache.save(id, updatedItem);
    emit(RepositoryItemUpdated(item, updatedItem));
    return updatedItem;
  }

  Future<void> delete(String id) async {
    final item = cache.getOrThrow(id);
    cache.delete(id);
    emit(RepositoryItemDeleted(item));
  }
}

sealed class _RepoEvent {
  const _RepoEvent();

  @override
  String toString() => 'RepoEvent';
}

class _RepoFetchEvent extends _RepoEvent {
  const _RepoFetchEvent();

  @override
  String toString() => 'RepoFetchEvent';
}

class _RepoUpdateItemEvent extends _RepoEvent {
  const _RepoUpdateItemEvent(this.id, this.newValue);

  final String id;
  final int newValue;

  @override
  String toString() => 'RepoUpdateItemEvent(id: $id, newValue: $newValue)';
}

class _RepoDeleteItemEvent extends _RepoEvent {
  const _RepoDeleteItemEvent(this.id);

  final String id;

  @override
  String toString() => 'RepoDeleteItemEvent(id: $id)';
}

class _RepoV2
    extends RepositoryV2<String, _Item, _RepoEvent, RepositoryState<_Item>> {
  _RepoV2() {
    on<_RepoFetchEvent, List<_Item>>((event, emit) => _fetch(emit));
    on<_RepoUpdateItemEvent, _Item>(
      (event, emit) => _update(event.id, event.newValue, emit),
    );
    on<_RepoDeleteItemEvent, _Item>((event, emit) => _delete(event.id, emit));
  }

  Future<List<_Item>> _fetch(Emitter<RepositoryState<_Item>?> emit) async {
    cache
      ..clear()
      ..addAll(_generate());
    emit(RepositoryCollectionFetched(cache.values.toList()));
    return cache.values.toList();
  }

  Future<_Item> _update(
    String id,
    int value,
    Emitter<RepositoryState<_Item>?> emit,
  ) async {
    await _wait();
    final item = getOrThrow(id);
    final updatedItem = item.copyWith(value: value);
    cache[id] = updatedItem;
    emit(RepositoryItemUpdated(item, updatedItem));
    return updatedItem;
  }

  Future<_Item> _delete(
    String id,
    Emitter<RepositoryState<_Item>?> emit,
  ) async {
    final item = getOrThrow(id);
    cache.remove(id);
    emit(RepositoryItemDeleted(item));
    return item;
  }
}

class _BlocObserver extends BlocObserver {
  const _BlocObserver();

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('${bloc.runtimeType} $event');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('${bloc.runtimeType} $error\n$stackTrace');
  }
}

void main() {
  late _Repo repo;
  late _RepoV2 repoV2;

  setUp(() {
    Bloc.observer = const _BlocObserver();
    repo = _Repo();
    repoV2 = _RepoV2();
  });

  tearDown(() {
    repo.close();
    repoV2.close();
  });

  group('Repository (old)', () {
    test('Throws on concurrent changes', () async {
      await repo.fetch();
      expect(repo.items.isNotEmpty, true);
      final id = repo.items.first.id;
      await expectLater(
        () => Future.wait([
          repo.update(id, 100),
          repo.delete(id),
        ]),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('RepositoryV2 (new)', () {
    test('Throws when executed concurrently', () async {
      await repoV2.addConcurrentAndWait<void>(const _RepoFetchEvent());
      expect(repoV2.items.isNotEmpty, true);
      final count = repoV2.items.length;
      final id = repoV2.values.first.id;
      await expectLater(
        () => Future.wait([
          repoV2.addConcurrentAndWait<void>(_RepoUpdateItemEvent(id, 100)),
          repoV2.addConcurrentAndWait<void>(_RepoDeleteItemEvent(id)),
        ]),
        throwsA(isA<ArgumentError>()),
      );
      // The item has been deleted. It's the update that failed.
      expect(repoV2.get(id), isNull);
      expect(repoV2.items.length, count - 1);
    });

    test('Does not throw when executed sequentially', () async {
      await repoV2.addSequentialAndWait<void>(const _RepoFetchEvent());
      expect(repoV2.items.isNotEmpty, true);
      final count = repoV2.items.length;
      final id = repoV2.values.first.id;
      await Future.wait([
        repoV2.addSequentialAndWait<void>(_RepoUpdateItemEvent(id, 100)),
        repoV2.addSequentialAndWait<void>(_RepoDeleteItemEvent(id)),
      ]);
      expect(repoV2.get(id), isNull);
      expect(repoV2.items.length, count - 1);
    });
  });
}
