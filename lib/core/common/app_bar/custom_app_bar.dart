import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final Widget? leading;
  final String title;

  const CustomAppBar({
    super.key,
    this.actions,
    this.leading,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      leading: leading,
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
