import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

/// Games screen for managing booked games, upcoming matches, and game history
class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Games',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Track your bookings and matches',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusSmall,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: AppColors.primary),
                      onPressed: () {
                        // Navigate to book new game
                        _showBookGameDialog();
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Tab bar
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusSmall,
                  ),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                tabs: const [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Live'),
                  Tab(text: 'History'),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  _UpcomingGamesTab(),
                  _LiveGamesTab(),
                  _HistoryGamesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookGameDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            const Text(
              'Book New Game',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            _BookingOption(
              icon: Icons.search,
              title: 'Find & Book Venue',
              subtitle: 'Browse available venues',
              onTap: () {
                Navigator.pop(context);
                // Navigate to explore screen
              },
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            _BookingOption(
              icon: Icons.group_add,
              title: 'Quick Match',
              subtitle: 'Find players for instant game',
              onTap: () {
                Navigator.pop(context);
                // Navigate to quick match
              },
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            _BookingOption(
              icon: Icons.schedule,
              title: 'Schedule Match',
              subtitle: 'Plan a future game with team',
              onTap: () {
                Navigator.pop(context);
                // Navigate to schedule match
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _BookingOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: AppDimensions.paddingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _UpcomingGamesTab extends StatelessWidget {
  const _UpcomingGamesTab();

  @override
  Widget build(BuildContext context) {
    final upcomingGames = [
      {
        'sport': 'Futsal',
        'venue': 'Sports Arena A',
        'date': 'Today, 6:00 PM',
        'players': '8/10',
        'status': 'confirmed',
      },
      {
        'sport': 'Tennis',
        'venue': 'Tennis Club B',
        'date': 'Tomorrow, 9:00 AM',
        'players': '2/4',
        'status': 'waiting',
      },
      {
        'sport': 'Basketball',
        'venue': 'Court Center C',
        'date': 'Fri, 7:30 PM',
        'players': '10/10',
        'status': 'confirmed',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
      ),
      itemCount: upcomingGames.length,
      itemBuilder: (context, index) {
        final game = upcomingGames[index];
        return _GameCard(
          sport: game['sport']!,
          venue: game['venue']!,
          date: game['date']!,
          players: game['players']!,
          status: game['status']!,
        );
      },
    );
  }
}

class _LiveGamesTab extends StatelessWidget {
  const _LiveGamesTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sports_soccer, size: 64, color: AppColors.textSecondary),
          SizedBox(height: AppDimensions.paddingMedium),
          Text(
            'No Live Games',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.paddingSmall),
          Text(
            'Your active games will appear here',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _HistoryGamesTab extends StatelessWidget {
  const _HistoryGamesTab();

  @override
  Widget build(BuildContext context) {
    final historyGames = [
      {
        'sport': 'Futsal',
        'venue': 'Sports Arena A',
        'date': 'Sep 10, 2024',
        'result': 'Won 3-2',
        'status': 'completed',
      },
      {
        'sport': 'Tennis',
        'venue': 'Tennis Club B',
        'date': 'Sep 8, 2024',
        'result': 'Lost 1-2',
        'status': 'completed',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
      ),
      itemCount: historyGames.length,
      itemBuilder: (context, index) {
        final game = historyGames[index];
        return _GameCard(
          sport: game['sport']!,
          venue: game['venue']!,
          date: game['date']!,
          players: game['result']!,
          status: game['status']!,
        );
      },
    );
  }
}

class _GameCard extends StatelessWidget {
  final String sport;
  final String venue;
  final String date;
  final String players;
  final String status;

  const _GameCard({
    required this.sport,
    required this.venue,
    required this.date,
    required this.players,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'confirmed':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'waiting':
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
        break;
      case 'completed':
        statusColor = Colors.blue;
        statusIcon = Icons.history;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.circle;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingSmall,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusSmall,
                        ),
                      ),
                      child: Text(
                        sport,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingSmall),
                    Icon(statusIcon, size: 16, color: statusColor),
                  ],
                ),
                Icon(Icons.more_vert, color: AppColors.textSecondary),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            Text(
              venue,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  players,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
