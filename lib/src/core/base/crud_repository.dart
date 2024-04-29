import '../../../a2f_sdk.dart';

abstract class CrudRepository<O, State> with LoggerMixin, Observable<State> {
  // TODO(calbi): we can add the crud operations;

  List<O> get items;

  O getItemOrThrow(String id);
}
