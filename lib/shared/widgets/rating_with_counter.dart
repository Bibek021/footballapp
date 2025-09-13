import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/svg_icons.dart';
import '../../../core/constants/app_constants.dart';

/// A reusable rating widget with counter
class RatingWithCounter extends StatelessWidget {
  const RatingWithCounter({
    super.key,
    required this.rating,
    required this.numOfRating,
  });

  final double rating;
  final int numOfRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          rating.toString(),
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: AppColors.textPrimary.withValues(alpha: 0.74),
          ),
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        SvgPicture.string(
          SvgIcons.rating,
          height: AppDimensions.iconSizeSmall,
          width: AppDimensions.iconSizeSmall,
          colorFilter: const ColorFilter.mode(
            AppColors.rating,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        Text(
          "$numOfRating+ Ratings",
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: AppColors.textPrimary.withValues(alpha: 0.74),
          ),
        ),
      ],
    );
  }
}
