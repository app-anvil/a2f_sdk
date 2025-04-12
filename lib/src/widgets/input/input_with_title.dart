import 'package:flext_core/flext_core.dart';
import 'package:flutter/widgets.dart';

import '../../style/style.dart';
import '../spans.dart';

class InputWithTitle extends StatelessWidget {
  const InputWithTitle({
    required this.title,
    required this.input,
    required this.isSmall,
    super.key,
  });

  final String title;

  final Widget input;

  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: context.tt.labelSmall?.copyWith(
            color: context.col.onSurface,
          ),
        ),
        VSpan($style.insets.xxs),
        input,
      ],
    );
  }
}
