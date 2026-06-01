import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? userType;
  final bool isVerified;
  final String? governorate;
  final String? gender;
  final double walletBalance;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    this.fullName,
    this.email,
    this.phone,
    this.avatar,
    this.userType,
    this.isVerified = false,
    this.governorate,
    this.gender,
    this.walletBalance = 0.0,
    this.createdAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      avatar: data['avatar'] ?? '',
      userType: data['role'] ?? 'patient',
      isVerified: data['isVerified'] ?? false,
      governorate: data['governorate'] ?? '',
      gender: data['gender'] ?? '',
      walletBalance: (data['walletBalance'] ?? 0).toDouble(),
      createdAt: _parseTimestamp(data['createdAt']),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? json['full_name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      userType: json['role'] ?? 'patient',
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'role': userType,
      'isVerified': isVerified,
    };
  }

  static DateTime? _parseTimestamp(dynamic timestamp) {
    if (timestamp == null) return null;
    if (timestamp is Timestamp) return timestamp.toDate();
    if (timestamp is String) return DateTime.tryParse(timestamp);
    return null;
  }

  String get displayName => fullName ?? 'مستخدم';
  String get initials {
    if (fullName == null || fullName!.isEmpty) return '?';
    final parts = fullName!.split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return fullName![0];
  }
}
