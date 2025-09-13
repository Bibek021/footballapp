import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

/// Challenges screen for creating and managing challenge matches between teams and players
class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen>
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
                        'Challenges',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Create competitions and accept challenges',
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
                        _showCreateChallengeDialog();
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
                  Tab(text: 'Open'),
                  Tab(text: 'My Challenges'),
                  Tab(text: 'Tournaments'),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  _OpenChallengesTab(),
                  _MyChallengesTab(),
                  _TournamentsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateChallengeDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
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
                'Create Challenge',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingLarge),
              _ChallengeOption(
                icon: Icons.sports_soccer,
                title: 'Team vs Team',
                subtitle: 'Challenge another team to a match',
                onTap: () {
                  Navigator.pop(context);
                  // Create team challenge
                },
              ),
              const SizedBox(height: AppDimensions.paddingMedium),
              _ChallengeOption(
                icon: Icons.person,
                title: '1v1 Challenge',
                subtitle: 'Challenge individual player',
                onTap: () {
                  Navigator.pop(context);
                  // Create 1v1 challenge
                },
              ),
              const SizedBox(height: AppDimensions.paddingMedium),
              _ChallengeOption(
                icon: Icons.emoji_events,
                title: 'Tournament',
                subtitle: 'Create multi-team tournament',
                onTap: () {
                  Navigator.pop(context);
                  // Create tournament
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChallengeOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ChallengeOption({
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

class _OpenChallengesTab extends StatelessWidget {
  const _OpenChallengesTab();

  @override
  Widget build(BuildContext context) {
    final openChallenges = [
      {
        'title': 'Thunder Bolts vs Anyone',
        'sport': 'Futsal',
        'type': 'Team Challenge',
        'date': 'This Weekend',
        'prize': '\$200 Winner Takes All',
        'participants': '1/2 Teams',
      },
      {
        'title': 'Tennis Masters 1v1',
        'sport': 'Tennis',
        'type': '1v1 Challenge',
        'date': 'Tomorrow 3PM',
        'prize': 'Glory & Bragging Rights',
        'participants': '1/2 Players',
      },
      {
        'title': 'Basketball Showdown',
        'sport': 'Basketball',
        'type': 'Team Challenge',
        'date': 'Next Friday',
        'prize': 'Trophy + \$500',
        'participants': '3/4 Teams',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
      ),
      itemCount: openChallenges.length,
      itemBuilder: (context, index) {
        final challenge = openChallenges[index];
        return _ChallengeCard(
          title: challenge['title'] as String,
          sport: challenge['sport'] as String,
          type: challenge['type'] as String,
          date: challenge['date'] as String,
          prize: challenge['prize'] as String,
          participants: challenge['participants'] as String,
          canJoin: true,
        );
      },
    );
  }
}

class _MyChallengesTab extends StatelessWidget {
  const _MyChallengesTab();

  @override
  Widget build(BuildContext context) {
    final myChallenges = [
      {
        'title': 'FC Warriors vs Lightning',
        'sport': 'Futsal',
        'type': 'Team Challenge',
        'date': 'Saturday 6PM',
        'status': 'Accepted',
        'participants': '2/2 Teams',
      },
      {
        'title': 'My Tennis Challenge',
        'sport': 'Tennis',
        'type': '1v1 Challenge',
        'date': 'Pending',
        'status': 'Waiting',
        'participants': '1/2 Players',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
      ),
      itemCount: myChallenges.length,
      itemBuilder: (context, index) {
        final challenge = myChallenges[index];
        return _ChallengeCard(
          title: challenge['title'] as String,
          sport: challenge['sport'] as String,
          type: challenge['type'] as String,
          date: challenge['date'] as String,
          prize: challenge['status'] as String,
          participants: challenge['participants'] as String,
          canJoin: false,
        );
      },
    );
  }
}

class _TournamentsTab extends StatelessWidget {
  const _TournamentsTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
      ),
      child: Column(
        children: [
          // Featured tournament
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.deepPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      size: 32,
                      color: Colors.white,
                    ),
                    const SizedBox(width: AppDimensions.paddingSmall),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'FEATURED',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.paddingSmall),
                const Text(
                  'City Championship',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Multi-sport tournament with prizes worth \$10,000',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                Row(
                  children: [
                    _TournamentStat(label: 'Teams', value: '64'),
                    const SizedBox(width: AppDimensions.paddingMedium),
                    _TournamentStat(label: 'Sports', value: '6'),
                    const SizedBox(width: AppDimensions.paddingMedium),
                    _TournamentStat(label: 'Days', value: '7'),
                  ],
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                ElevatedButton(
                  onPressed: () {
                    // Join tournament
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple,
                  ),
                  child: const Text('Join Tournament'),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          // Other tournaments
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Other Tournaments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('View All')),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return _TournamentCard(
                  name: 'Tournament ${index + 1}',
                  sport: ['Futsal', 'Tennis', 'Basketball'][index],
                  teams: '${16 - index * 4}/32',
                  prize: '\$${2000 - index * 500}',
                  date: 'Starting ${index + 1} weeks',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TournamentStat extends StatelessWidget {
  final String label;
  final String value;

  const _TournamentStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.8)),
        ),
      ],
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final String title;
  final String sport;
  final String type;
  final String date;
  final String prize;
  final String participants;
  final bool canJoin;

  const _ChallengeCard({
    required this.title,
    required this.sport,
    required this.type,
    required this.date,
    required this.prize,
    required this.participants,
    required this.canJoin,
  });

  @override
  Widget build(BuildContext context) {
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusSmall,
                        ),
                      ),
                      child: Text(
                        type,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
                if (canJoin)
                  ElevatedButton(
                    onPressed: () {
                      // Join challenge
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingMedium,
                        vertical: AppDimensions.paddingSmall,
                      ),
                      minimumSize: Size.zero,
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            Text(
              title,
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
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.emoji_events,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  prize,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  participants,
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

class _TournamentCard extends StatelessWidget {
  final String name;
  final String sport;
  final String teams;
  final String prize;
  final String date;

  const _TournamentCard({
    required this.name,
    required this.sport,
    required this.teams,
    required this.prize,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
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
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              ),
              child: const Icon(
                Icons.emoji_events,
                color: AppColors.primary,
                size: 30,
              ),
            ),
            const SizedBox(width: AppDimensions.paddingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$sport • $teams teams',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        'Prize: $prize',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingSmall),
                      Text(
                        '• $date',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
