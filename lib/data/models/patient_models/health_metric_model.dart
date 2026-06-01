import 'package:equatable/equatable.dart';

class HealthMetricModel extends Equatable {
  final String id;
  final String userId;
  final String metricType;
  final double value;
  final String? unit;
  final String? notes;
  final DateTime recordedAt;
  final DateTime? createdAt;

  const HealthMetricModel({
    required this.id, required this.userId, required this.metricType,
    required this.value, this.unit, this.notes,
    required this.recordedAt, this.createdAt,
  });

  factory HealthMetricModel.fromJson(Map<String, dynamic> json) {
    return HealthMetricModel(
      id: json['id'] ?? '', userId: json['user_id'] ?? '',
      metricType: json['metric_type'] ?? '',
      value: (json['value'] ?? 0).toDouble(),
      unit: json['unit'], notes: json['notes'],
      recordedAt: DateTime.parse(json['recorded_at'] ?? DateTime.now().toIso8601String()),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 'user_id': userId, 'metric_type': metricType,
      'value': value, 'unit': unit, 'notes': notes,
      'recorded_at': recordedAt.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, userId, metricType, value, unit, notes, recordedAt, createdAt];
}
