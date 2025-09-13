import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

/// Explore screen for discovering sports venues and facilities
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _selectedSport = '';
  bool _isSearchFocused = false;

  // Sample data - In real app, this would come from API/Database
  final List<Map<String, dynamic>> _featuredSports = [
    {
      'name': 'Futsal',
      'icon': Icons.sports_soccer,
      'color': Colors.blue,
      'venues': 25,
      'gradient': [Color(0xFF667eea), Color(0xFF764ba2)],
    },
    {
      'name': 'Tennis',
      'icon': Icons.sports_tennis,
      'color': Colors.green,
      'venues': 18,
      'gradient': [Color(0xFF11998e), Color(0xFF38ef7d)],
    },
    {
      'name': 'Basketball',
      'icon': Icons.sports_basketball,
      'color': Colors.orange,
      'venues': 12,
      'gradient': [Color(0xFFfc4a1a), Color(0xFFf7b733)],
    },
    {
      'name': 'Golf',
      'icon': Icons.sports_golf,
      'color': Colors.teal,
      'venues': 8,
      'gradient': [Color(0xFF4facfe), Color(0xFF00f2fe)],
    },
  ];

  final List<Map<String, dynamic>> _nearbyVenues = [
    {
      'name': 'Elite Sports Complex',
      'address': 'Downtown District',
      'sports': ['Futsal', 'Tennis', 'Basketball'],
      'distance': 0.8,
      'rating': 4.8,
      'price': 25,
      'image': 'assets/images/venue1.jpg',
      'isOpen': true,
      'features': ['Parking', 'Locker Room', 'Cafe'],
    },
    {
      'name': 'Metro Sports Arena',
      'address': 'City Center',
      'sports': ['Badminton', 'Table Tennis', 'Squash'],
      'distance': 1.2,
      'rating': 4.6,
      'price': 20,
      'image': 'assets/images/venue2.jpg',
      'isOpen': true,
      'features': ['AC', 'Parking', 'Equipment Rental'],
    },
    {
      'name': 'Champions Court',
      'address': 'Sports District',
      'sports': ['Basketball', 'Volleyball'],
      'distance': 2.1,
      'rating': 4.7,
      'price': 30,
      'image': 'assets/images/venue3.jpg',
      'isOpen': false,
      'features': ['Professional Courts', 'Changing Room'],
    },
    {
      'name': 'Green Valley Golf Club',
      'address': 'Hillside Area',
      'sports': ['Golf'],
      'distance': 5.5,
      'rating': 4.9,
      'price': 80,
      'image': 'assets/images/venue4.jpg',
      'isOpen': true,
      'features': ['18 Holes', 'Pro Shop', 'Restaurant'],
    },
    {
      'name': 'Aqua Sports Center',
      'address': 'Marina District',
      'sports': ['Swimming', 'Water Polo'],
      'distance': 3.2,
      'rating': 4.5,
      'price': 15,
      'image': 'assets/images/venue5.jpg',
      'isOpen': true,
      'features': ['Olympic Pool', 'Sauna', 'Gym'],
    },
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredVenues {
    if (_selectedSport.isEmpty) return _nearbyVenues;
    return _nearbyVenues
        .where((venue) => venue['sports'].contains(_selectedSport))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Custom app bar with search
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: AppColors.background,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(background: _buildHeader()),
          ),
          // Search bar
          SliverToBoxAdapter(child: _buildSearchBar()),
          // Featured sports section
          SliverToBoxAdapter(child: _buildFeaturedSports()),
          // Quick filters
          SliverToBoxAdapter(child: _buildQuickFilters()),
          // Nearby venues header
          SliverToBoxAdapter(
            child: _buildSectionHeader('Nearby Venues', 'See all'),
          ),
          // Venues list
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final venues = _filteredVenues;
              if (index >= venues.length) return null;
              return _buildVenueCard(venues[index]);
            }, childCount: _filteredVenues.length),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Explore',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Find amazing sports venues near you',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onTap: () => setState(() => _isSearchFocused = true),
        onEditingComplete: () => setState(() => _isSearchFocused = false),
        decoration: InputDecoration(
          hintText: 'Search venues, sports, areas...',
          hintStyle: TextStyle(color: AppColors.textSecondary),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: _isSearchFocused
                ? AppColors.primary
                : AppColors.textSecondary,
            size: 24,
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(Icons.tune, color: AppColors.primary, size: 20),
              onPressed: _showFilterBottomSheet,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildFeaturedSports() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Featured Sports', null),
        SizedBox(
          height: 140,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _featuredSports.length,
            itemBuilder: (context, index) {
              final sport = _featuredSports[index];
              return _buildFeaturedSportCard(sport, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedSportCard(Map<String, dynamic> sport, int index) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 16, left: index == 0 ? 0 : 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: sport['gradient'],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: sport['gradient'][0].withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _selectSport(sport['name']),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(sport['icon'], size: 32, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  sport['name'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  '${sport['venues']} venues',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickFilters() {
    final filters = ['All', 'Open Now', 'Nearby', 'Top Rated', 'Budget'];
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final isSelected = index == 0; // Default first filter as selected
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(filters[index]),
              selected: isSelected,
              onSelected: (selected) {
                // Handle filter selection
              },
              backgroundColor: Colors.white,
              selectedColor: AppColors.primary.withValues(alpha: 0.1),
              checkmarkColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected ? AppColors.primary : Colors.grey.shade300,
                width: 1,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, String? action) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          if (action != null)
            TextButton(
              onPressed: () {
                // Handle action
              },
              child: Text(
                action,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVenueCard(Map<String, dynamic> venue) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _openVenueDetails(venue),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Venue image
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withValues(alpha: 0.1),
                            AppColors.primary.withValues(alpha: 0.2),
                          ],
                        ),
                      ),
                      child: Icon(
                        _getSportIcon(venue['sports'][0]),
                        size: 32,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Venue info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  venue['name'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              if (!venue['isOpen'])
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Closed',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            venue['address'],
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${venue['distance']} km',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                Icons.star_rounded,
                                size: 14,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${venue['rating']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Price and booking
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${venue['price']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const Text(
                          '/hour',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: venue['isOpen']
                              ? () => _bookVenue(venue)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            disabledBackgroundColor: Colors.grey.shade300,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            minimumSize: Size.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            venue['isOpen'] ? 'Book' : 'Closed',
                            style: TextStyle(
                              color: venue['isOpen']
                                  ? Colors.white
                                  : Colors.grey.shade600,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Sports tags
                Wrap(
                  spacing: 8,
                  children: (venue['sports'] as List<String>)
                      .take(3)
                      .map(
                        (sport) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            sport,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 8),
                // Features
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 14,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      (venue['features'] as List<String>).join(' • '),
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectSport(String sport) {
    setState(() {
      _selectedSport = _selectedSport == sport ? '' : sport;
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Filters',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Add filter options here
            const Text('Distance'),
            const SizedBox(height: 8),
            // Distance slider, price range, etc.
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Clear'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openVenueDetails(Map<String, dynamic> venue) {
    // Navigate to venue details page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${venue['name']} details...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _bookVenue(Map<String, dynamic> venue) {
    // Navigate to booking page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking ${venue['name']}...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  IconData _getSportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'futsal':
        return Icons.sports_soccer;
      case 'tennis':
        return Icons.sports_tennis;
      case 'basketball':
        return Icons.sports_basketball;
      case 'badminton':
        return Icons.sports_tennis; // Use tennis icon for badminton
      case 'golf':
        return Icons.sports_golf;
      case 'swimming':
        return Icons.pool;
      case 'volleyball':
        return Icons.sports_volleyball;
      default:
        return Icons.sports;
    }
  }
}
