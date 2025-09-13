import 'package:flutter/material.dart';

/// A small circular dot widget used for separating text elements
class SmallDot extends StatelessWidget {
  const SmallDot({super.key, this.color, this.size = 4.0});

  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color:
            color ??
            Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.4),
        shape: BoxShape.circle,
      ),
    );
  }
}
