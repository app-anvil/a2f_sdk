import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'state_status.dart';

@immutable
abstract class SuperBlocState<E> extends Equatable {
  final E? error;
  final StateStatus status;

  const SuperBlocState({
    required this.status,
    required this.error,
  }) : assert(
          status == StateStatus.failure && error != null ||
              status != StateStatus.failure && error == null,
          'When status is failure, error must be not null and vice versa.',
        );

  const SuperBlocState.initial()
      : this(
          status: StateStatus.initial,
          error: null,
        );

  SuperBlocState<E> copyWith({required StateStatus status});

  SuperBlocState<E> copyWithError(E error);

  @override
  @mustCallSuper
  List<Object?> get props => [status, error];

  @override
  bool? get stringify => false;
}
