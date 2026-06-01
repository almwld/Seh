import 'package:equatable/equatable.dart';

class InsuranceCompanyModel extends Equatable {
  final String id;
  final String name;
  final String? logo;
  final String? description;
  final String? phone;
  final String? email;
  final String? website;
  final double? rating;
  final bool? isActive;
  final DateTime? createdAt;

  const InsuranceCompanyModel({
    required this.id, required this.name, this.logo, this.description,
    this.phone, this.email, this.website, this.rating, this.isActive, this.createdAt,
  });

  factory InsuranceCompanyModel.fromJson(Map<String, dynamic> json) {
    return InsuranceCompanyModel(
      id: json['id'] ?? '', name: json['name'] ?? '', logo: json['logo'],
      description: json['description'], phone: json['phone'],
      email: json['email'], website: json['website'],
      rating: json['rating']?.toDouble(), isActive: json['is_active'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  @override
  List<Object?> get props => [id, name, logo, description, phone, email, website, rating, isActive, createdAt];
}

class InsurancePlanModel extends Equatable {
  final String id;
  final String companyId;
  final String name;
  final String? description;
  final double price;
  final String? duration;
  final List<String>? coverage;
  final List<String>? benefits;
  final bool? isActive;
  final DateTime? createdAt;

  const InsurancePlanModel({
    required this.id, required this.companyId, required this.name,
    this.description, required this.price, this.duration,
    this.coverage, this.benefits, this.isActive, this.createdAt,
  });

  factory InsurancePlanModel.fromJson(Map<String, dynamic> json) {
    return InsurancePlanModel(
      id: json['id'] ?? '', companyId: json['company_id'] ?? '',
      name: json['name'] ?? '', description: json['description'],
      price: (json['price'] ?? 0).toDouble(), duration: json['duration'],
      coverage: json['coverage'] != null ? List<String>.from(json['coverage']) : null,
      benefits: json['benefits'] != null ? List<String>.from(json['benefits']) : null,
      isActive: json['is_active'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  @override
  List<Object?> get props => [id, companyId, name, description, price, duration, coverage, benefits, isActive, createdAt];
}
