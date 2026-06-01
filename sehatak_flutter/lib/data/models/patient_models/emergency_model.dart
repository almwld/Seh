import 'package:equatable/equatable.dart';

class EmergencyNumberModel extends Equatable {
  final String id;
  final String name;
  final String number;
  final String? description;
  final String? category;
  final String? icon;
  final bool? isActive;
  final DateTime? createdAt;

  const EmergencyNumberModel({
    required this.id, required this.name, required this.number,
    this.description, this.category, this.icon, this.isActive, this.createdAt,
  });

  factory EmergencyNumberModel.fromJson(Map<String, dynamic> json) {
    return EmergencyNumberModel(
      id: json['id'] ?? '', name: json['name'] ?? '',
      number: json['number'] ?? '', description: json['description'],
      category: json['category'], icon: json['icon'],
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  @override
  List<Object?> get props => [id, name, number, description, category, icon, isActive, createdAt];
}

class EmergencyContactModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String phone;
  final String? relationship;
  final bool? isPrimary;
  final DateTime? createdAt;

  const EmergencyContactModel({
    required this.id, required this.userId, required this.name,
    required this.phone, this.relationship, this.isPrimary, this.createdAt,
  });

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) {
    return EmergencyContactModel(
      id: json['id'] ?? '', userId: json['user_id'] ?? '',
      name: json['name'] ?? '', phone: json['phone'] ?? '',
      relationship: json['relationship'], isPrimary: json['is_primary'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 'user_id': userId, 'name': name, 'phone': phone,
      'relationship': relationship, 'is_primary': isPrimary,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, userId, name, phone, relationship, isPrimary, createdAt];
}
