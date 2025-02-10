import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Widget child;

  final Color background;
  final Color? disabledBackground;

  final double minHeight;
  final double? minWidth;

  final EdgeInsets padding;

  final void Function()? onPressed;

  const AppButton({
    super.key,
    required this.background,
    required this.child,
    this.minHeight = 56.0,
    this.minWidth,
    this.padding = EdgeInsets.zero,
    this.disabledBackground,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size minSize;
    if (minWidth != null) {
      minSize = Size(minWidth!, minHeight);
    } else {
      minSize = Size.fromHeight(minHeight);
    }

    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all<Size>(minSize),
        padding: WidgetStateProperty.all<EdgeInsets>(padding),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        elevation: WidgetStateProperty.all<double>(0),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return disabledBackground;
            }

            return background;
          },
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
