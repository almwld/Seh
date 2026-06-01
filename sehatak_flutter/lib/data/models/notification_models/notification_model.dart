import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String body;
  final String? image;
  final String? data;
  final String? type;
  final bool isRead;
  final DateTime createdAt;

  const NotificationModel({
    required this.id, required this.userId, required this.title,
    required this.body, this.image, this.data, this.type,
    this.isRead = false, required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '', userId: json['user_id'] ?? '',
      title: json['title'] ?? '', body: json['body'] ?? '',
      image: json['image'], data: json['data'], type: json['type'],
      isRead: json['is_read'] ?? false,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 'user_id': userId, 'title': title, 'body': body,
      'image': image, 'data': data, 'type': type,
      'is_read': isRead, 'created_at': createdAt.toIso8601String(),
    };
  }

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id, userId: userId, title: title, body: body,
      image: image, data: data, type: type,
      isRead: isRead ?? this.isRead, createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [id, userId, title, body, image, data, type, isRead, createdAt];
}
