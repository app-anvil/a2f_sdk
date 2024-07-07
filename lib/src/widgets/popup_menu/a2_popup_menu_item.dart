part of 'a2_popup_menu_button.dart';

class A2PopupMenuItem {
  static final A2PopupMenuItem divider = A2PopupMenuItem(
    title: '',
    onPressed: () => throw UnsupportedError(
      'Divider item should not be pressed',
    ),
  );

  final Icon? icon;
  final String title;
  final String? subtitle;
  final Icon? trailingIcon;
  final VoidCallback onPressed;
  final Color Function(BuildContext context)? getColor;

  A2PopupMenuItem({
    required this.title,
    required this.onPressed,
    this.icon,
    this.subtitle,
    this.trailingIcon,
    this.getColor,
  });

  A2PopupMenuItem copyWith({VoidCallback? onPressed}) => A2PopupMenuItem(
        title: title,
        subtitle: subtitle,
        icon: icon,
        trailingIcon: trailingIcon,
        getColor: getColor,
        onPressed: onPressed ?? this.onPressed,
      );
}
