import 'package:flutter_test/flutter_test.dart';
import '../../../../example/repository.dart';

void main() {
  group('Singleton repository', () {
    final inMemoryDataSource = TodoInMemoryDataSource();
    final todoRepository = TodoSingletonRepository(inMemoryDataSource);

    test('Get the current item', () {
      final item = todoRepository.item;

      expect(item, isNull);
    });
  });

  group('Repository', () {
    final inMemoryDataSource = TodoInMemoryDataSource();
    final todoRepository = TodoRepository(inMemoryDataSource);
    test('Fetch todos', () async {
      final todos = await todoRepository.fetch();

      expect(todos.length, 2);
    });

    test('Get todos', () {
      final todos = todoRepository.items;

      expect(todos.length, 2);
    });
  });
}
