import 'package:flutter/material.dart';

/// A skeleton line widget for loading states
class SkeletonLine extends StatelessWidget {
  const SkeletonLine({
    super.key,
    this.height = 15,
    this.width = double.infinity,
    this.borderRadius = 0,
  });

  final double height, width, borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
