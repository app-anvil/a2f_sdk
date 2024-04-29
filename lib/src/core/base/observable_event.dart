import '../../../a2f_sdk.dart';

/// State class to be used with [Observable].
class ObservableEvent<State> extends Equatable {
  const ObservableEvent(this.previousState, this.state);
  final State? previousState;
  final State state;

  @override
  List<Object?> get props => [previousState, state];
}
