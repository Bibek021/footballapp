/// Sports venue model for explore feature
class Venue {
  final String id;
  final String name;
  final String address;
  final List<String> sports;
  final double distance;
  final double rating;
  final int reviewCount;
  final double pricePerHour;
  final String imageUrl;
  final bool isOpen;
  final List<String> features;
  final Map<String, dynamic> location;
  final Map<String, String> openingHours;

  const Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.sports,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.pricePerHour,
    required this.imageUrl,
    required this.isOpen,
    required this.features,
    required this.location,
    required this.openingHours,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      sports: List<String>.from(json['sports'] ?? []),
      distance: (json['distance'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      pricePerHour: (json['pricePerHour'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      isOpen: json['isOpen'] ?? false,
      features: List<String>.from(json['features'] ?? []),
      location: json['location'] ?? {},
      openingHours: Map<String, String>.from(json['openingHours'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'sports': sports,
      'distance': distance,
      'rating': rating,
      'reviewCount': reviewCount,
      'pricePerHour': pricePerHour,
      'imageUrl': imageUrl,
      'isOpen': isOpen,
      'features': features,
      'location': location,
      'openingHours': openingHours,
    };
  }
}

/// Sport category model
class SportCategory {
  final String id;
  final String name;
  final String iconPath;
  final List<int> gradientColors;
  final int venueCount;

  const SportCategory({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.gradientColors,
    required this.venueCount,
  });

  factory SportCategory.fromJson(Map<String, dynamic> json) {
    return SportCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      iconPath: json['iconPath'] ?? '',
      gradientColors: List<int>.from(json['gradientColors'] ?? []),
      venueCount: json['venueCount'] ?? 0,
    );
  }
}

/// Search filter model
class VenueFilter {
  final String searchQuery;
  final List<String> selectedSports;
  final double maxDistance;
  final double minRating;
  final double maxPrice;
  final bool openNowOnly;
  final List<String> selectedFeatures;

  const VenueFilter({
    this.searchQuery = '',
    this.selectedSports = const [],
    this.maxDistance = 10.0,
    this.minRating = 0.0,
    this.maxPrice = 100.0,
    this.openNowOnly = false,
    this.selectedFeatures = const [],
  });

  VenueFilter copyWith({
    String? searchQuery,
    List<String>? selectedSports,
    double? maxDistance,
    double? minRating,
    double? maxPrice,
    bool? openNowOnly,
    List<String>? selectedFeatures,
  }) {
    return VenueFilter(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedSports: selectedSports ?? this.selectedSports,
      maxDistance: maxDistance ?? this.maxDistance,
      minRating: minRating ?? this.minRating,
      maxPrice: maxPrice ?? this.maxPrice,
      openNowOnly: openNowOnly ?? this.openNowOnly,
      selectedFeatures: selectedFeatures ?? this.selectedFeatures,
    );
  }
}
