import 'package:flutter/material.dart';
import '../models/venue.dart';

/// ViewModel for the explore screen following MVVM architecture
class ExploreViewModel extends ChangeNotifier {
  // State management
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  // Data
  List<Venue> _allVenues = [];
  List<Venue> _filteredVenues = [];
  List<SportCategory> _featuredSports = [];
  VenueFilter _currentFilter = const VenueFilter();

  // Getters
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  List<Venue> get venues => _filteredVenues;
  List<SportCategory> get featuredSports => _featuredSports;
  VenueFilter get currentFilter => _currentFilter;

  // Constructor
  ExploreViewModel() {
    _initializeData();
  }

  /// Initialize sample data - In production, this would fetch from API
  void _initializeData() {
    _setLoading(true);

    // Simulate API call delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _featuredSports = [
        SportCategory(
          id: '1',
          name: 'Futsal',
          iconPath: 'soccer',
          gradientColors: [0xFF667eea, 0xFF764ba2],
          venueCount: 25,
        ),
        SportCategory(
          id: '2',
          name: 'Tennis',
          iconPath: 'tennis',
          gradientColors: [0xFF11998e, 0xFF38ef7d],
          venueCount: 18,
        ),
        SportCategory(
          id: '3',
          name: 'Basketball',
          iconPath: 'basketball',
          gradientColors: [0xFFfc4a1a, 0xFFf7b733],
          venueCount: 12,
        ),
        SportCategory(
          id: '4',
          name: 'Golf',
          iconPath: 'golf',
          gradientColors: [0xFF4facfe, 0xFF00f2fe],
          venueCount: 8,
        ),
      ];

      _allVenues = [
        Venue(
          id: '1',
          name: 'Elite Sports Complex',
          address: 'Downtown District, Main Street 123',
          sports: ['Futsal', 'Tennis', 'Basketball'],
          distance: 0.8,
          rating: 4.8,
          reviewCount: 156,
          pricePerHour: 25.0,
          imageUrl: 'assets/images/venue1.jpg',
          isOpen: true,
          features: ['Parking', 'Locker Room', 'Cafe', 'AC'],
          location: {'lat': 40.7128, 'lng': -74.0060},
          openingHours: {
            'monday': '6:00 AM - 10:00 PM',
            'tuesday': '6:00 AM - 10:00 PM',
            'wednesday': '6:00 AM - 10:00 PM',
            'thursday': '6:00 AM - 10:00 PM',
            'friday': '6:00 AM - 11:00 PM',
            'saturday': '7:00 AM - 11:00 PM',
            'sunday': '8:00 AM - 9:00 PM',
          },
        ),
        Venue(
          id: '2',
          name: 'Metro Sports Arena',
          address: 'City Center, Arena Boulevard 45',
          sports: ['Badminton', 'Table Tennis', 'Squash'],
          distance: 1.2,
          rating: 4.6,
          reviewCount: 89,
          pricePerHour: 20.0,
          imageUrl: 'assets/images/venue2.jpg',
          isOpen: true,
          features: ['AC', 'Parking', 'Equipment Rental'],
          location: {'lat': 40.7589, 'lng': -73.9851},
          openingHours: {
            'monday': '7:00 AM - 9:00 PM',
            'tuesday': '7:00 AM - 9:00 PM',
            'wednesday': '7:00 AM - 9:00 PM',
            'thursday': '7:00 AM - 9:00 PM',
            'friday': '7:00 AM - 10:00 PM',
            'saturday': '8:00 AM - 10:00 PM',
            'sunday': '9:00 AM - 8:00 PM',
          },
        ),
        Venue(
          id: '3',
          name: 'Champions Court',
          address: 'Sports District, Victory Lane 78',
          sports: ['Basketball', 'Volleyball'],
          distance: 2.1,
          rating: 4.7,
          reviewCount: 203,
          pricePerHour: 30.0,
          imageUrl: 'assets/images/venue3.jpg',
          isOpen: false, // Currently closed
          features: ['Professional Courts', 'Changing Room', 'Scoreboard'],
          location: {'lat': 40.7505, 'lng': -73.9934},
          openingHours: {
            'monday': '5:00 AM - 11:00 PM',
            'tuesday': '5:00 AM - 11:00 PM',
            'wednesday': '5:00 AM - 11:00 PM',
            'thursday': '5:00 AM - 11:00 PM',
            'friday': '5:00 AM - 12:00 AM',
            'saturday': '6:00 AM - 12:00 AM',
            'sunday': '7:00 AM - 10:00 PM',
          },
        ),
        Venue(
          id: '4',
          name: 'Green Valley Golf Club',
          address: 'Hillside Area, Golf Course Road 12',
          sports: ['Golf'],
          distance: 5.5,
          rating: 4.9,
          reviewCount: 412,
          pricePerHour: 80.0,
          imageUrl: 'assets/images/venue4.jpg',
          isOpen: true,
          features: ['18 Holes', 'Pro Shop', 'Restaurant', 'Caddy Service'],
          location: {'lat': 40.8176, 'lng': -73.9782},
          openingHours: {
            'monday': '6:00 AM - 8:00 PM',
            'tuesday': '6:00 AM - 8:00 PM',
            'wednesday': '6:00 AM - 8:00 PM',
            'thursday': '6:00 AM - 8:00 PM',
            'friday': '6:00 AM - 9:00 PM',
            'saturday': '5:30 AM - 9:00 PM',
            'sunday': '6:00 AM - 8:00 PM',
          },
        ),
        Venue(
          id: '5',
          name: 'Aqua Sports Center',
          address: 'Marina District, Harbor View 34',
          sports: ['Swimming', 'Water Polo'],
          distance: 3.2,
          rating: 4.5,
          reviewCount: 67,
          pricePerHour: 15.0,
          imageUrl: 'assets/images/venue5.jpg',
          isOpen: true,
          features: ['Olympic Pool', 'Sauna', 'Gym', 'Hot Tub'],
          location: {'lat': 40.7282, 'lng': -74.0776},
          openingHours: {
            'monday': '5:00 AM - 10:00 PM',
            'tuesday': '5:00 AM - 10:00 PM',
            'wednesday': '5:00 AM - 10:00 PM',
            'thursday': '5:00 AM - 10:00 PM',
            'friday': '5:00 AM - 11:00 PM',
            'saturday': '6:00 AM - 11:00 PM',
            'sunday': '7:00 AM - 9:00 PM',
          },
        ),
      ];

      _filteredVenues = List.from(_allVenues);
      _setLoading(false);
    });
  }

  /// Search venues based on query
  void searchVenues(String query) {
    _currentFilter = _currentFilter.copyWith(searchQuery: query);
    _applyFilters();
  }

  /// Filter venues by sport
  void filterBySport(String sport) {
    List<String> selectedSports = List.from(_currentFilter.selectedSports);

    if (selectedSports.contains(sport)) {
      selectedSports.remove(sport);
    } else {
      selectedSports.add(sport);
    }

    _currentFilter = _currentFilter.copyWith(selectedSports: selectedSports);
    _applyFilters();
  }

  /// Update filter settings
  void updateFilter(VenueFilter newFilter) {
    _currentFilter = newFilter;
    _applyFilters();
  }

  /// Clear all filters
  void clearFilters() {
    _currentFilter = const VenueFilter();
    _applyFilters();
  }

  /// Apply current filters to venue list
  void _applyFilters() {
    List<Venue> filtered = List.from(_allVenues);

    // Apply search query filter
    if (_currentFilter.searchQuery.isNotEmpty) {
      final query = _currentFilter.searchQuery.toLowerCase();
      filtered = filtered.where((venue) {
        return venue.name.toLowerCase().contains(query) ||
            venue.address.toLowerCase().contains(query) ||
            venue.sports.any((sport) => sport.toLowerCase().contains(query));
      }).toList();
    }

    // Apply sports filter
    if (_currentFilter.selectedSports.isNotEmpty) {
      filtered = filtered.where((venue) {
        return venue.sports.any(
          (sport) => _currentFilter.selectedSports.contains(sport),
        );
      }).toList();
    }

    // Apply distance filter
    filtered = filtered
        .where((venue) => venue.distance <= _currentFilter.maxDistance)
        .toList();

    // Apply rating filter
    filtered = filtered
        .where((venue) => venue.rating >= _currentFilter.minRating)
        .toList();

    // Apply price filter
    filtered = filtered
        .where((venue) => venue.pricePerHour <= _currentFilter.maxPrice)
        .toList();

    // Apply open now filter
    if (_currentFilter.openNowOnly) {
      filtered = filtered.where((venue) => venue.isOpen).toList();
    }

    // Apply features filter
    if (_currentFilter.selectedFeatures.isNotEmpty) {
      filtered = filtered.where((venue) {
        return _currentFilter.selectedFeatures.every(
          (feature) => venue.features.contains(feature),
        );
      }).toList();
    }

    _filteredVenues = filtered;
    notifyListeners();
  }

  /// Refresh venue data
  Future<void> refreshVenues() async {
    _setLoading(true);
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _initializeData();
  }

  /// Get venues by sport category
  List<Venue> getVenuesBySport(String sport) {
    return _allVenues.where((venue) => venue.sports.contains(sport)).toList();
  }

  /// Sort venues by different criteria
  void sortVenues(String criteria) {
    switch (criteria) {
      case 'distance':
        _filteredVenues.sort((a, b) => a.distance.compareTo(b.distance));
        break;
      case 'rating':
        _filteredVenues.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'price':
        _filteredVenues.sort(
          (a, b) => a.pricePerHour.compareTo(b.pricePerHour),
        );
        break;
      case 'name':
        _filteredVenues.sort((a, b) => a.name.compareTo(b.name));
        break;
    }
    notifyListeners();
  }

  /// Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Set error state
  void _setError(String message) {
    _hasError = true;
    _errorMessage = message;
    _isLoading = false;
    notifyListeners();
  }

  /// Clear error state
  void clearError() {
    _hasError = false;
    _errorMessage = '';
    notifyListeners();
  }
}
