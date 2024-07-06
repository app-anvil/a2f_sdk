import 'dart:async';

import 'repository.dart';

void main() async {
  unawaited(repository());
  singleton();
}

Future<void> repository() async {
  final todoRepository = TodoRepository(TodoInMemoryDataSource());

  final todos = await todoRepository.fetch();

  // ignore: avoid_print
  print('$todos');
}

void singleton() {
  final todoRepository = TodoSingletonRepository(TodoInMemoryDataSource());

  final item = todoRepository.item;
  // ignore: avoid_print
  print('$item');
}
