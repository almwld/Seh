import 'package:equatable/equatable.dart';

class DoctorModel extends Equatable {
  final String id;
  final String userId;
  final String fullName;
  final String? avatar;
  final String specialization;
  final String? subSpecialization;
  final String? bio;
  final double experience;
  final double rating;
  final int reviewCount;
  final String? certificateNumber;
  final String? university;
  final List<String>? languages;
  final double consultationPrice;
  final double? followUpPrice;
  final bool isAvailable;
  final bool isVerified;
  final bool isFavorite;
  final String? clinicAddress;
  final String? clinicPhone;
  final double? latitude;
  final double? longitude;
  final String? workingHours;
  final List<String>? services;
  final DateTime? createdAt;

  const DoctorModel({
    required this.id,
    required this.userId,
    required this.fullName,
    this.avatar,
    required this.specialization,
    this.subSpecialization,
    this.bio,
    this.experience = 0,
    this.rating = 0,
    this.reviewCount = 0,
    this.certificateNumber,
    this.university,
    this.languages,
    this.consultationPrice = 0,
    this.followUpPrice,
    this.isAvailable = false,
    this.isVerified = false,
    this.isFavorite = false,
    this.clinicAddress,
    this.clinicPhone,
    this.latitude,
    this.longitude,
    this.workingHours,
    this.services,
    this.createdAt,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      fullName: json['full_name'] ?? '',
      avatar: json['avatar'],
      specialization: json['specialization'] ?? '',
      subSpecialization: json['sub_specialization'],
      bio: json['bio'],
      experience: (json['experience'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
      certificateNumber: json['certificate_number'],
      university: json['university'],
      languages: json['languages'] != null ? List<String>.from(json['languages']) : null,
      consultationPrice: (json['consultation_price'] ?? 0).toDouble(),
      followUpPrice: json['follow_up_price'] != null ? (json['follow_up_price']).toDouble() : null,
      isAvailable: json['is_available'] ?? false,
      isVerified: json['is_verified'] ?? false,
      isFavorite: json['is_favorite'] ?? false,
      clinicAddress: json['clinic_address'],
      clinicPhone: json['clinic_phone'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      workingHours: json['working_hours'],
      services: json['services'] != null ? List<String>.from(json['services']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'full_name': fullName,
      'avatar': avatar,
      'specialization': specialization,
      'sub_specialization': subSpecialization,
      'bio': bio,
      'experience': experience,
      'rating': rating,
      'review_count': reviewCount,
      'certificate_number': certificateNumber,
      'university': university,
      'languages': languages,
      'consultation_price': consultationPrice,
      'follow_up_price': followUpPrice,
      'is_available': isAvailable,
      'is_verified': isVerified,
      'is_favorite': isFavorite,
      'clinic_address': clinicAddress,
      'clinic_phone': clinicPhone,
      'latitude': latitude,
      'longitude': longitude,
      'working_hours': workingHours,
      'services': services,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  DoctorModel copyWith({
    String? id, String? userId, String? fullName, String? avatar,
    String? specialization, String? subSpecialization, String? bio,
    double? experience, double? rating, int? reviewCount,
    String? certificateNumber, String? university, List<String>? languages,
    double? consultationPrice, double? followUpPrice, bool? isAvailable,
    bool? isVerified, bool? isFavorite, String? clinicAddress,
    String? clinicPhone, double? latitude, double? longitude,
    String? workingHours, List<String>? services, DateTime? createdAt,
  }) {
    return DoctorModel(
      id: id ?? this.id, userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName, avatar: avatar ?? this.avatar,
      specialization: specialization ?? this.specialization,
      subSpecialization: subSpecialization ?? this.subSpecialization,
      bio: bio ?? this.bio, experience: experience ?? this.experience,
      rating: rating ?? this.rating, reviewCount: reviewCount ?? this.reviewCount,
      certificateNumber: certificateNumber ?? this.certificateNumber,
      university: university ?? this.university,
      languages: languages ?? this.languages,
      consultationPrice: consultationPrice ?? this.consultationPrice,
      followUpPrice: followUpPrice ?? this.followUpPrice,
      isAvailable: isAvailable ?? this.isAvailable,
      isVerified: isVerified ?? this.isVerified,
      isFavorite: isFavorite ?? this.isFavorite,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      clinicPhone: clinicPhone ?? this.clinicPhone,
      latitude: latitude ?? this.latitude, longitude: longitude ?? this.longitude,
      workingHours: workingHours ?? this.workingHours,
      services: services ?? this.services, createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id, userId, fullName, avatar, specialization, subSpecialization,
    bio, experience, rating, reviewCount, certificateNumber, university,
    languages, consultationPrice, followUpPrice, isAvailable, isVerified,
    isFavorite, clinicAddress, clinicPhone, latitude, longitude,
    workingHours, services, createdAt,
  ];
}

class DoctorReviewModel extends Equatable {
  final String id;
  final String doctorId;
  final String patientId;
  final String patientName;
  final String? patientAvatar;
  final double rating;
  final String comment;
  final DateTime createdAt;

  const DoctorReviewModel({
    required this.id, required this.doctorId, required this.patientId,
    required this.patientName, this.patientAvatar, required this.rating,
    required this.comment, required this.createdAt,
  });

  factory DoctorReviewModel.fromJson(Map<String, dynamic> json) {
    return DoctorReviewModel(
      id: json['id'] ?? '', doctorId: json['doctor_id'] ?? '',
      patientId: json['patient_id'] ?? '', patientName: json['patient_name'] ?? '',
      patientAvatar: json['patient_avatar'],
      rating: (json['rating'] ?? 0).toDouble(),
      comment: json['comment'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  @override
  List<Object?> get props => [id, doctorId, patientId, patientName, rating, comment, createdAt];
}
