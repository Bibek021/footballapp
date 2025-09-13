/// Navigation tab model
class NavTab {
  final String label;
  final String icon;
  final int index;

  const NavTab({required this.label, required this.icon, required this.index});
}

/// Available navigation tabs
class NavTabs {
  static const explore = NavTab(label: 'Explore', icon: 'explore', index: 0);

  static const games = NavTab(label: 'Games', icon: 'games', index: 1);

  static const teams = NavTab(label: 'Teams', icon: 'teams', index: 2);

  static const challenges = NavTab(
    label: 'Challenges',
    icon: 'challenges',
    index: 3,
  );

  static const profile = NavTab(label: 'Profile', icon: 'profile', index: 4);

  static const List<NavTab> all = [explore, games, teams, challenges, profile];
}
