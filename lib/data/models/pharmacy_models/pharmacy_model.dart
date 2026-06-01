import 'package:equatable/equatable.dart';

class PharmacyModel extends Equatable {
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
  final List<String>? services;
  final DateTime? createdAt;

  const PharmacyModel({
    required this.id, required this.name, this.logo, this.address,
    this.phone, this.email, this.latitude, this.longitude, this.rating,
    this.reviewCount, this.isOpen, this.workingHours, this.isFavorite,
    this.services, this.createdAt,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      id: json['id'] ?? '', name: json['name'] ?? '', logo: json['logo'],
      address: json['address'], phone: json['phone'], email: json['email'],
      latitude: json['latitude']?.toDouble(), longitude: json['longitude']?.toDouble(),
      rating: json['rating']?.toDouble(), reviewCount: json['review_count'],
      isOpen: json['is_open'], workingHours: json['working_hours'],
      isFavorite: json['is_favorite'],
      services: json['services'] != null ? List<String>.from(json['services']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  @override
  List<Object?> get props => [
    id, name, logo, address, phone, email, latitude, longitude,
    rating, reviewCount, isOpen, workingHours, isFavorite, services, createdAt,
  ];
}

class ProductModel extends Equatable {
  final String id;
  final String pharmacyId;
  final String name;
  final String? description;
  final String? image;
  final String? category;
  final double price;
  final double? originalPrice;
  final int? quantity;
  final String? unit;
  final bool? requiresPrescription;
  final bool? inStock;
  final double? rating;
  final int? reviewCount;
  final List<String>? tags;
  final DateTime? expiryDate;

  const ProductModel({
    required this.id, required this.pharmacyId, required this.name,
    this.description, this.image, this.category, required this.price,
    this.originalPrice, this.quantity, this.unit,
    this.requiresPrescription, this.inStock, this.rating,
    this.reviewCount, this.tags, this.expiryDate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '', pharmacyId: json['pharmacy_id'] ?? '',
      name: json['name'] ?? '', description: json['description'],
      image: json['image'], category: json['category'],
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: json['original_price']?.toDouble(),
      quantity: json['quantity'], unit: json['unit'],
      requiresPrescription: json['requires_prescription'],
      inStock: json['in_stock'], rating: json['rating']?.toDouble(),
      reviewCount: json['review_count'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      expiryDate: json['expiry_date'] != null ? DateTime.parse(json['expiry_date']) : null,
    );
  }

  @override
  List<Object?> get props => [
    id, pharmacyId, name, description, image, category, price,
    originalPrice, quantity, unit, requiresPrescription, inStock,
    rating, reviewCount, tags, expiryDate,
  ];
}

class CartItemModel extends Equatable {
  final String productId;
  final String name;
  final String? image;
  final double price;
  final int quantity;
  final String? pharmacyId;

  const CartItemModel({
    required this.productId, required this.name, this.image,
    required this.price, required this.quantity, this.pharmacyId,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['product_id'] ?? '', name: json['name'] ?? '',
      image: json['image'], price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1, pharmacyId: json['pharmacy_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId, 'name': name, 'image': image,
      'price': price, 'quantity': quantity, 'pharmacy_id': pharmacyId,
    };
  }

  double get totalPrice => price * quantity;

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      productId: productId, name: name, image: image,
      price: price, quantity: quantity ?? this.quantity, pharmacyId: pharmacyId,
    );
  }

  @override
  List<Object?> get props => [productId, name, image, price, quantity, pharmacyId];
}
