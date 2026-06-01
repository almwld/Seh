import 'package:equatable/equatable.dart';

class LabModel extends Equatable {
  final String id;
  final String name;
  final String? logo;
  final String? address;
  final String? phone;
  final String? email;
  final double? latitude;
  final double? longitude;
  final double? rating;
  final int? reviewCount;
  final bool? isOpen;
  final String? workingHours;
  final bool? isFavorite;
  final bool? homeVisitAvailable;
  final DateTime? createdAt;

  const LabModel({
    required this.id, required this.name, this.logo, this.address,
    this.phone, this.email, this.latitude, this.longitude, this.rating,
    this.reviewCount, this.isOpen, this.workingHours, this.isFavorite,
    this.homeVisitAvailable, this.createdAt,
  });

  factory LabModel.fromJson(Map<String, dynamic> json) {
    return LabModel(
      id: json['id'] ?? '', name: json['name'] ?? '', logo: json['logo'],
      address: json['address'], phone: json['phone'], email: json['email'],
      latitude: json['latitude']?.toDouble(), longitude: json['longitude']?.toDouble(),
      rating: json['rating']?.toDouble(), reviewCount: json['review_count'],
      isOpen: json['is_open'], workingHours: json['working_hours'],
      isFavorite: json['is_favorite'], homeVisitAvailable: json['home_visit_available'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  @override
  List<Object?> get props => [
    id, name, logo, address, phone, email, latitude, longitude,
    rating, reviewCount, isOpen, workingHours, isFavorite, homeVisitAvailable, createdAt,
  ];
}

class LabTestModel extends Equatable {
  final String id;
  final String labId;
  final String name;
  final String? description;
  final String? category;
  final double price;
  final double? originalPrice;
  final String? duration;
  final String? preparationInstructions;
  final bool? homeVisitAvailable;
  final DateTime? createdAt;

  const LabTestModel({
    required this.id, required this.labId, required this.name,
    this.description, this.category, required this.price,
    this.originalPrice, this.duration, this.preparationInstructions,
    this.homeVisitAvailable, this.createdAt,
  });

  factory LabTestModel.fromJson(Map<String, dynamic> json) {
    return LabTestModel(
      id: json['id'] ?? '', labId: json['lab_id'] ?? '', name: json['name'] ?? '',
      description: json['description'], category: json['category'],
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: json['original_price']?.toDouble(),
      duration: json['duration'], preparationInstructions: json['preparation_instructions'],
      homeVisitAvailable: json['home_visit_available'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  @override
  List<Object?> get props => [
    id, labId, name, description, category, price, originalPrice,
    duration, preparationInstructions, homeVisitAvailable, createdAt,
  ];
}
