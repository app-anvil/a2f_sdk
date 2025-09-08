import 'dart:async';

import 'package:flutter/foundation.dart' show debugPrint;

import 'repository.dart';

void main() async {
  unawaited(repository());
  singleton();
}

Future<void> repository() async {
  final todoRepository = TodoRepository(TodoInMemoryDataSource());

  final todos = await todoRepository.fetch();

  debugPrint('$todos');
}

void singleton() {
  final todoRepository = TodoSingletonRepository(TodoInMemoryDataSource());

  final item = todoRepository.item;
  debugPrint('$item');
}
