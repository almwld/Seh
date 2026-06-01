import 'package:equatable/equatable.dart';

class ReportModel extends Equatable {
  final String id;
  final String userId;
  final String reportType;
  final String title;
  final String? description;
  final String? fileUrl;
  final String? fileType;
  final String status;
  final DateTime? generatedAt;
  final DateTime? createdAt;

  const ReportModel({
    required this.id, required this.userId, required this.reportType,
    required this.title, this.description, this.fileUrl,
    this.fileType, this.status = 'pending', this.generatedAt, this.createdAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] ?? '', userId: json['user_id'] ?? '',
      reportType: json['report_type'] ?? '', title: json['title'] ?? '',
      description: json['description'], fileUrl: json['file_url'],
      fileType: json['file_type'], status: json['status'] ?? 'pending',
      generatedAt: json['generated_at'] != null ? DateTime.parse(json['generated_at']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  @override
  List<Object?> get props => [
    id, userId, reportType, title, description,
    fileUrl, fileType, status, generatedAt, createdAt,
  ];
}
