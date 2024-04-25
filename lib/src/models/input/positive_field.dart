import 'package:formz/formz.dart';

/// Validation errors for the [RequiredField] [FormzInput].
class PositiveFieldValidationError {
  ///
  PositiveFieldValidationError(this.message);

  /// Indicates the failure message.
  final String message;
}

/// {@template positive_field}
/// Form input for a positive integer input.
/// {@endtemplate}
class PositiveField extends FormzInput<num, PositiveFieldValidationError> {
  /// {@macro positive_field}
  const PositiveField.pure() : super.pure(1);

  /// {@macro positive_field}
  const PositiveField.dirty([super.value = 1]) : super.dirty();

  @override
  PositiveFieldValidationError? validator(num value) {
    return value < 1
        // fixme: l10n
        ? PositiveFieldValidationError(
            'This field must be greater than or equal to 1',
          )
        : null;
  }
}
