import 'package:easilybecho/core/common/app_Indicator.dart';
import 'package:easilybecho/core/navigation/app_navigators.dart';
import 'package:flutter/material.dart';

class CommonBtns {
  static Widget elevatedButton({
    required void Function()? onPressed,
    required String title,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? backgroundColor,
    Color? foregroundColor,
    bool disable = false,
    bool isLoading = false, // ← new: shows spinner inside button
  }) {
    return ElevatedButton(
      onPressed: (disable || isLoading) ? null : onPressed,
      autofocus: autofocus,
      focusNode: focusNode,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: AppIndicator.circularProgress(),
            )
          : Text(title),
    );
  }

  static Widget elevatedButtonIcon({
    required void Function()? onPressed,
    required Widget label,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? backgroundColor,
    Color? foregroundColor,
    bool disable = false,
    bool isLoading = false,
    Widget? icon,
  }) {
    return ElevatedButton.icon(
      onPressed: (disable || isLoading) ? null : onPressed,
      autofocus: autofocus,
      focusNode: focusNode,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      label: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: AppIndicator.circularProgress(),
            )
          : label,
      icon: isLoading ? const SizedBox.shrink() : icon,
    );
  }

  static Widget outlinedButton({
    required void Function()? onPressed,
    required String title,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? backgroundColor,
    Color? foregroundColor,
    bool disable = false,
    bool isLoading = false,
  }) {
    return OutlinedButton(
      onPressed: (disable || isLoading) ? null : onPressed,
      autofocus: autofocus,
      focusNode: focusNode,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: AppIndicator.circularProgress(),
            )
          : Text(title),
    );
  }

  static Widget outlinedButtonIcon({
    required void Function()? onPressed,
    required Widget label,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? backgroundColor,
    Color? foregroundColor,
    bool disable = false,
    bool isLoading = false,
    Widget? icon,
  }) {
    return OutlinedButton.icon(
      onPressed: (disable || isLoading) ? null : onPressed,
      autofocus: autofocus,
      focusNode: focusNode,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      label: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: AppIndicator.circularProgress(),
            )
          : label,
      icon: isLoading ? const SizedBox.shrink() : icon,
    );
  }

  static Widget iconButton({
    required void Function()? onPressed,
    required Widget icon,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? backgroundColor,
    Color? foregroundColor,
    bool disable = false,
  }) {
    return IconButton(
      onPressed: disable ? null : onPressed,
      autofocus: autofocus,
      focusNode: focusNode,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      icon: icon,
    );
  }

  static Widget iconButtonFilled({
    required void Function()? onPressed,
    required Widget icon,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? backgroundColor,
    Color? foregroundColor,
    bool disable = false,
  }) {
    return IconButton.filled(
      onPressed: disable ? null : onPressed,
      autofocus: autofocus,
      focusNode: focusNode,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      icon: icon,
    );
  }

  static Widget iconButtonOutlined({
    required void Function()? onPressed,
    required Widget icon,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? backgroundColor,
    Color? foregroundColor,
    bool disable = false,
  }) {
    return IconButton.outlined(
      onPressed: disable ? null : onPressed,
      autofocus: autofocus,
      focusNode: focusNode,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      icon: icon,
    );
  }

  static Widget iconButtonFilledTonal({
    required void Function()? onPressed,
    required Widget icon,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? backgroundColor,
    Color? foregroundColor,
    bool disable = false,
  }) {
    return IconButton.filledTonal(
      onPressed: disable ? null : onPressed,
      autofocus: autofocus,
      focusNode: focusNode,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      icon: icon,
    );
  }

  static Widget textButton({
    required void Function()? onPressed,
    required Widget child,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? backgroundColor,
    Color? foregroundColor,
    bool disable = false,
  }) {
    return TextButton(
      onPressed: disable ? null : onPressed,
      autofocus: autofocus,
      focusNode: focusNode,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: child,
    );
  }

  static Widget textButtonIcon({
    required void Function()? onPressed,
    required Widget label,
    Widget? icon,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? backgroundColor,
    Color? foregroundColor,
    bool disable = false,
  }) {
    return TextButton.icon(
      onPressed: disable ? null : onPressed,
      autofocus: autofocus,
      focusNode: focusNode,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      label: label,
      icon: icon,
    );
  }

  static Widget backButton({void Function()? onPressed, Color? color}) {
    return BackButton(onPressed: onPressed ?? AppNavigators.pop, color: color);
  }

  static Widget closeButton({void Function()? onPressed, Color? color}) {
    return CloseButton(onPressed: onPressed ?? AppNavigators.pop, color: color);
  }
}
