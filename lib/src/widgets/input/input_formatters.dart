import 'package:flutter/services.dart';

class ReplaceCommaFormatter extends TextInputFormatter {
  final String replaceWith;

  ReplaceCommaFormatter(this.replaceWith);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.replaceAll(',', replaceWith),
      selection: newValue.selection,
    );
  }
}
