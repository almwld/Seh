import 'package:equatable/equatable.dart';

class WalletModel extends Equatable {
  final String id;
  final String userId;
  final double balance;
  final String currency;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const WalletModel({
    required this.id, required this.userId, required this.balance,
    this.currency = 'YER', this.isActive = true, this.createdAt, this.updatedAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'] ?? '', userId: json['user_id'] ?? '',
      balance: (json['balance'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'YER', isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 'user_id': userId, 'balance': balance,
      'currency': currency, 'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, userId, balance, currency, isActive, createdAt, updatedAt];
}

class TransactionModel extends Equatable {
  final String id;
  final String walletId;
  final String type;
  final double amount;
  final String currency;
  final String? description;
  final String status;
  final String? paymentMethod;
  final DateTime createdAt;

  const TransactionModel({
    required this.id, required this.walletId, required this.type,
    required this.amount, this.currency = 'YER', this.description,
    this.status = 'completed', this.paymentMethod, required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? '', walletId: json['wallet_id'] ?? '',
      type: json['type'] ?? '', amount: (json['amount'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'YER', description: json['description'],
      status: json['status'] ?? 'completed', paymentMethod: json['payment_method'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  @override
  List<Object?> get props => [id, walletId, type, amount, currency, description, status, paymentMethod, createdAt];
}
