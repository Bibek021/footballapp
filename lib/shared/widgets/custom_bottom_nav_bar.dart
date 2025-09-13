import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/svg_icons.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/nav_tabs.dart';

/// Custom bottom navigation bar widget
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingSmall,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: NavTabs.all.map((tab) {
              final isSelected = tab.index == currentIndex;
              return _NavBarItem(
                tab: tab,
                isSelected: isSelected,
                onTap: () => onTap(tab.index),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  final NavTab tab;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSmall,
          vertical: AppDimensions.paddingSmall,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.string(
              _getIconSvg(tab.icon),
              height: AppDimensions.iconSize,
              width: AppDimensions.iconSize,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.navSelected : AppColors.navUnselected,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              tab.label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isSelected
                    ? AppColors.navSelected
                    : AppColors.navUnselected,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getIconSvg(String iconName) {
    switch (iconName) {
      case 'explore':
        return SvgIcons.explore;
      case 'games':
        return SvgIcons.games;
      case 'teams':
        return SvgIcons.teams;
      case 'challenges':
        return SvgIcons.challenges;
      case 'profile':
        return SvgIcons.profile;
      default:
        return SvgIcons.explore;
    }
  }
}
