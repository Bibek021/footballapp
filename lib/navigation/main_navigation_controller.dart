import 'package:flutter/material.dart';
import '../features/explore/views/explore_screen.dart';
import '../features/games/views/games_screen.dart';
import '../features/teams/views/teams_screen.dart';
import '../features/challenges/views/challenges_screen.dart';
import '../features/profile/views/profile_screen.dart';
import '../shared/widgets/custom_bottom_nav_bar.dart';

/// Main navigation controller that manages bottom navigation for SportsMatch app
class MainNavigationController extends StatefulWidget {
  const MainNavigationController({super.key});

  @override
  State<MainNavigationController> createState() =>
      _MainNavigationControllerState();
}

class _MainNavigationControllerState extends State<MainNavigationController> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ExploreScreen(), // Index 0: Explore venues and sports
    const GamesScreen(), // Index 1: Manage bookings and games
    const TeamsScreen(), // Index 2: Team management and matchmaking
    const ChallengesScreen(), // Index 3: Tournaments and challenges
    const ProfileScreen(), // Index 4: User profile and settings
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
