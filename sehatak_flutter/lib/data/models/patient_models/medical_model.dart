import 'package:equatable/equatable.dart';

class MedicalRecordModel extends Equatable {
  final String id;
  final String patientId;
  final String? doctorId;
  final String? doctorName;
  final String recordType;
  final String title;
  final String? description;
  final String? diagnosis;
  final String? treatment;
  final String? notes;
  final List<String>? attachments;
  final DateTime recordDate;
  final DateTime? createdAt;

  const MedicalRecordModel({
    required this.id, required this.patientId, this.doctorId, this.doctorName,
    required this.recordType, required this.title, this.description,
    this.diagnosis, this.treatment, this.notes, this.attachments,
    required this.recordDate, this.createdAt,
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    return MedicalRecordModel(
      id: json['id'] ?? '', patientId: json['patient_id'] ?? '',
      doctorId: json['doctor_id'], doctorName: json['doctor_name'],
      recordType: json['record_type'] ?? '', title: json['title'] ?? '',
      description: json['description'], diagnosis: json['diagnosis'],
      treatment: json['treatment'], notes: json['notes'],
      attachments: json['attachments'] != null ? List<String>.from(json['attachments']) : null,
      recordDate: DateTime.parse(json['record_date'] ?? DateTime.now().toIso8601String()),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  @override
  List<Object?> get props => [
    id, patientId, doctorId, doctorName, recordType, title,
    description, diagnosis, treatment, notes, attachments, recordDate, createdAt,
  ];
}

class PrescriptionModel extends Equatable {
  final String id;
  final String patientId;
  final String? doctorId;
  final String? doctorName;
  final String? pharmacyId;
  final String? pharmacyName;
  final List<MedicationModel>? medications;
  final String? notes;
  final String? status;
  final DateTime prescriptionDate;
  final DateTime? expiryDate;
  final DateTime? createdAt;

  const PrescriptionModel({
    required this.id, required this.patientId, this.doctorId, this.doctorName,
    this.pharmacyId, this.pharmacyName, this.medications, this.notes,
    this.status, required this.prescriptionDate, this.expiryDate, this.createdAt,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      id: json['id'] ?? '', patientId: json['patient_id'] ?? '',
      doctorId: json['doctor_id'], doctorName: json['doctor_name'],
      pharmacyId: json['pharmacy_id'], pharmacyName: json['pharmacy_name'],
      medications: json['medications'] != null
          ? (json['medications'] as List).map((e) => MedicationModel.fromJson(e)).toList()
          : null,
      notes: json['notes'], status: json['status'],
      prescriptionDate: DateTime.parse(json['prescription_date'] ?? DateTime.now().toIso8601String()),
      expiryDate: json['expiry_date'] != null ? DateTime.parse(json['expiry_date']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  @override
  List<Object?> get props => [
    id, patientId, doctorId, doctorName, pharmacyId, pharmacyName,
    medications, notes, status, prescriptionDate, expiryDate, createdAt,
  ];
}

class MedicationModel extends Equatable {
  final String id;
  final String name;
  final String? dosage;
  final String? frequency;
  final String? duration;
  final String? instructions;
  final String? type;
  final bool? isActive;
  final DateTime? startDate;
  final DateTime? endDate;

  const MedicationModel({
    required this.id, required this.name, this.dosage, this.frequency,
    this.duration, this.instructions, this.type, this.isActive,
    this.startDate, this.endDate,
  });

  factory MedicationModel.fromJson(Map<String, dynamic> json) {
    return MedicationModel(
      id: json['id'] ?? '', name: json['name'] ?? '',
      dosage: json['dosage'], frequency: json['frequency'],
      duration: json['duration'], instructions: json['instructions'],
      type: json['type'], isActive: json['is_active'],
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
    );
  }

  @override
  List<Object?> get props => [id, name, dosage, frequency, duration, instructions, type, isActive, startDate, endDate];
}
