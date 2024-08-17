import 'package:flext/flext.dart';
import 'package:flutter/material.dart';

part 'a2_popup_menu_item.dart';

class A2PopupMenuButton extends StatelessWidget {
  final List<A2PopupMenuItem> items;
  final String? tooltip;
  final Widget? child;
  final Icon? icon;
  final bool dense;
  final Offset offset;

  A2PopupMenuButton({
    required this.items,
    this.tooltip,
    this.dense = true,
    this.offset = Offset.zero,
    super.key,
  })  : icon = null,
        child = null,
        assert(items.isNotEmpty, 'Items should not be empty');

  A2PopupMenuButton.icon({
    required this.items,
    required Icon this.icon,
    this.tooltip,
    this.dense = true,
    this.offset = Offset.zero,
    super.key,
  })  : child = null,
        assert(items.isNotEmpty, 'Items should not be empty');

  A2PopupMenuButton.child({
    required this.items,
    required Widget this.child,
    this.tooltip,
    this.dense = true,
    this.offset = Offset.zero,
    super.key,
  })  : icon = null,
        assert(items.isNotEmpty, 'Items should not be empty');

  PopupMenuEntry<Never> _buildDivider() => const PopupMenuItem<Never>(
        value: null,
        height: 0,
        enabled: false,
        padding: EdgeInsets.zero,
        child: Divider(
          height: 8,
          indent: 16,
          endIndent: 16,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: child == null && icon == null ? const Icon(Icons.more_vert) : icon,
      initialValue: null,
      tooltip: tooltip ?? '',
      position: PopupMenuPosition.under,
      offset: offset,
      onSelected: (i) {
        final item = items[i];
        if (item == A2PopupMenuItem.divider) return;
        item.onPressed();
      },
      itemBuilder: (BuildContext context) => items
          .mapIndexed(
            (i, item) => item == A2PopupMenuItem.divider
                ? _buildDivider()
                : PopupMenuItem<int>(
                    value: i,
                    height: 0,
                    padding: EdgeInsets.zero,
                    mouseCursor: SystemMouseCursors.click,
                    child: ListTile(
                      mouseCursor: SystemMouseCursors.click,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      minVerticalPadding: 6,
                      horizontalTitleGap: 16,
                      visualDensity: const VisualDensity(
                        vertical: VisualDensity.minimumDensity,
                        horizontal: VisualDensity.minimumDensity,
                      ),
                      dense: dense,
                      leading: item.icon,
                      iconColor: item.getColor?.call(context),
                      textColor: item.getColor?.call(context),
                      title: Text(item.title),
                      subtitle:
                          item.subtitle != null ? Text(item.subtitle!) : null,
                      trailing: item.trailingIcon,
                    ),
                  ) as PopupMenuEntry<int>,
          )
          .toList(),
      child: child,
    );
  }
}
