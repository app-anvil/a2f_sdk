import 'dart:async';

import 'repository.dart';

void main() async {
  unawaited(repository());
  singleton();
}

Future<void> repository() async {
  final inMemoryDataSource = TodoInMemoryDataSource();
  final todoRepository = TodoRepository(inMemoryDataSource);

  final todos = await todoRepository.fetch();

  // ignore: avoid_print
  print('$todos');
}

void singleton() {
  final inMemoryDataSource = TodoInMemoryDataSource();
  final todoRepository = TodoSingletonRepository(inMemoryDataSource);

  final item = todoRepository.item;
  // ignore: avoid_print
  print('$item');
}
