import 'package:equatable/equatable.dart';

class AppointmentModel extends Equatable {
  final String id;
  final String patientId;
  final String doctorId;
  final String? doctorName;
  final String? doctorAvatar;
  final String? doctorSpecialization;
  final String? patientName;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String status;
  final String? type;
  final String? notes;
  final double? price;
  final String? currency;
  final bool? isPaid;
  final String? paymentMethod;
  final String? cancellationReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AppointmentModel({
    required this.id, required this.patientId, required this.doctorId,
    this.doctorName, this.doctorAvatar, this.doctorSpecialization,
    this.patientName, required this.appointmentDate, required this.appointmentTime,
    this.status = 'pending', this.type, this.notes, this.price,
    this.currency, this.isPaid, this.paymentMethod,
    this.cancellationReason, this.createdAt, this.updatedAt,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] ?? '', patientId: json['patient_id'] ?? '',
      doctorId: json['doctor_id'] ?? '', doctorName: json['doctor_name'],
      doctorAvatar: json['doctor_avatar'], doctorSpecialization: json['doctor_specialization'],
      patientName: json['patient_name'],
      appointmentDate: DateTime.parse(json['appointment_date'] ?? DateTime.now().toIso8601String()),
      appointmentTime: json['appointment_time'] ?? '', status: json['status'] ?? 'pending',
      type: json['type'], notes: json['notes'], price: json['price']?.toDouble(),
      currency: json['currency'], isPaid: json['is_paid'], paymentMethod: json['payment_method'],
      cancellationReason: json['cancellation_reason'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 'patient_id': patientId, 'doctor_id': doctorId,
      'doctor_name': doctorName, 'doctor_avatar': doctorAvatar,
      'doctor_specialization': doctorSpecialization, 'patient_name': patientName,
      'appointment_date': appointmentDate.toIso8601String(),
      'appointment_time': appointmentTime, 'status': status,
      'type': type, 'notes': notes, 'price': price,
      'currency': currency, 'is_paid': isPaid, 'payment_method': paymentMethod,
      'cancellation_reason': cancellationReason,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  AppointmentModel copyWith({
    String? id, String? patientId, String? doctorId, String? doctorName,
    String? doctorAvatar, String? doctorSpecialization, String? patientName,
    DateTime? appointmentDate, String? appointmentTime, String? status,
    String? type, String? notes, double? price, String? currency,
    bool? isPaid, String? paymentMethod, String? cancellationReason,
    DateTime? createdAt, DateTime? updatedAt,
  }) {
    return AppointmentModel(
      id: id ?? this.id, patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId, doctorName: doctorName ?? this.doctorName,
      doctorAvatar: doctorAvatar ?? this.doctorAvatar,
      doctorSpecialization: doctorSpecialization ?? this.doctorSpecialization,
      patientName: patientName ?? this.patientName,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      status: status ?? this.status, type: type ?? this.type,
      notes: notes ?? this.notes, price: price ?? this.price,
      currency: currency ?? this.currency, isPaid: isPaid ?? this.isPaid,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      createdAt: createdAt ?? this.createdAt, updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id, patientId, doctorId, doctorName, doctorAvatar, doctorSpecialization,
    patientName, appointmentDate, appointmentTime, status, type, notes,
    price, currency, isPaid, paymentMethod, cancellationReason, createdAt, updatedAt,
  ];
}
