// ignore_for_file: comment_references

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../a2f_sdk.dart';

/// {@template observable}
/// Emits a stream of object of type [S].
/// {@endtemplate}
mixin ObservableMixin<S> on LoggerMixin {
  /// The state controller.
  ///
  /// It does not emit the last event when a new listener subscribes to it.
  final _subject = PublishSubject<S>();

  /// Whether the [stream] is closed.
  ///
  /// If true the stream cannot be listened to and the [emit] function must
  /// not be called.
  @nonVirtual
  bool get isClosed => _subject.isClosed;

  /// Emits a new [newState] to the [stream].
  ///
  ///
  /// This method should not be called after [close] is called.
  @protected
  @nonVirtual
  void emit(S newState) {
    if (isClosed) {
      throw StateError('Cannot emit new states after calling close');
    }

    _subject.add(newState);
    logger.v('$runtimeType: $newState');
  }

  /// Closes the instance.
  ///
  /// This method should be called when the instance is no longer needed.
  /// Once [close] is called, the instance can no longer be used.
  @mustCallSuper
  @protected
  Future<void> close() async {
    await _subject.close();
  }

  /// Listens the stream of states.
  @nonVirtual
  StreamSubscription<S> listen(
    void Function(S state) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      _subject.stream.listen(
        (value) => onData(value),
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );
}

// New version of the Observable
// mixin Observable2<State> on LoggerMixin {
//   /// Get the stream.
//   ///
//   /// If [subject] is true only new object will be emitted, otherwise also the
//   /// last object will be emitted.
//   // Maybe it is redundant with listen method.
//   Stream<State> states({bool subject = true});

//   late Subject<ObservableEvent<State>> _subject;

//   /// The initial state of the instance.
//   ///
//   /// Cannot be null if the last object is not emitted.
//   @protected
//   State? get initialState;

//   /// The current state of the instance.
//   State? get state {
//     if (_subject is! ValueStream) return null;
//     return (_subject as BehaviorSubject<ObservableEvent<State>>).value.state;
//   }

//   /// The previous state of the instance.
//   ///
//   /// It is not null only if the subject is a ValueStream aka a BehaviorSubject.
//   State? get previousState {
//     if (_subject is! ValueStream) return null;
//     return (_subject as BehaviorSubject<ObservableEvent<State>>)
//         .value
//         .previousState;
//   }

//   /// Whether the [_subject] is closed.
//   ///
//   /// If true the stream cannot be listened to and the [emit] function must
//   /// not be called.
//   @nonVirtual
//   bool get isClosed => _subject.isClosed;

//   /// Emits a new [newState] to the [stream].
//   ///
//   ///
//   /// This method should not be called after [close] is called.
//   @protected
//   @nonVirtual
//   void emit(State newState) {
//     if (isClosed) {
//       throw StateError('Cannot emit new states after calling close');
//     }

//     final previousState = state;
//     final newEvent = ObservableEvent(previousState, newState);
//     _subject.add(newEvent);
//     logger.v('$runtimeType: $previousState ==> $newState');
//   }

//   /// We use the stream of subject.
//   @nonVirtual
//   StreamSubscription<ObservableEvent<State>> listen(
//     void Function(State? previousState, State state) onData, {
//     Function? onError,
//     void Function()? onDone,
//     bool? cancelOnError,
//   }) =>
//       _subject.listen(
//         (value) => onData(value.previousState, value.state),
//         onError: onError,
//         onDone: onDone,
//         cancelOnError: cancelOnError,
//       );

//   /// Closes the instance.
//   ///
//   /// This method should be called when the instance is no longer needed.
//   /// Once [close] is called, the instance can no longer be used.
//   @mustCallSuper
//   @protected
//   Future<void> close() async {
//     await _subject.close();
//   }
// }
