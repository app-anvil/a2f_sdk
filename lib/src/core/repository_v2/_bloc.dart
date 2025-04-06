part of 'repository_v2.dart';

typedef RepositoryV2EventOnSuccess<R> = void Function(R result);
typedef RepositoryV2EventOnError = void Function(
  Object error,
  StackTrace stackTrace,
);

sealed class _BlocEvent<R, Event, State> {
  final Event repoEvent;
  final RepositoryV2EventOnSuccess<R>? onSuccess;
  final RepositoryV2EventOnError? onError;

  _BlocEvent(
    this.repoEvent, {
    this.onSuccess,
    this.onError,
  });

  @override
  String toString() => '$repoEvent';
}

final class _SequentialBlocEvent<R, Event, State>
    extends _BlocEvent<R, Event, State> {
  _SequentialBlocEvent(
    super.repoEvent, {
    super.onSuccess,
    super.onError,
  });
}

final class _ConcurrentBlocEvent<R, Event, State>
    extends _BlocEvent<R, Event, State> {
  _ConcurrentBlocEvent(
    super.repoEvent, {
    super.onSuccess,
    super.onError,
  });
}

final class _RepoBloc<R, Event, State>
    extends Bloc<_BlocEvent<R, Event, State>, State?> {
  _RepoBloc() : super(null);
}
