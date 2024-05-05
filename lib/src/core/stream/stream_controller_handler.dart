import 'dart:async';

class StreamControllerHandler<T> {
  StreamControllerHandler();

  final _streamController = StreamController<T?>();

  Stream<T?> get stream => _streamController.stream;

  StreamSubscription<T?> listen(
    void Function(T?)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _streamController.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  /// Add a new value to the stream.
  void add(T? value) {
    _streamController.add(value);
  }
}
