import '../../domain/entities/legal_resource_entity.dart';

class LegalResourceModel extends LegalResourceEntity {
  const LegalResourceModel({
    required super.id,
    required super.title,
    super.description,
    super.fileUrl,
    super.imageUrl,
    super.createdAt,
    super.updatedAt,
  });

  factory LegalResourceModel.fromJson(Map<String, dynamic> json) {
    return LegalResourceModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'],
      fileUrl: json['file'],
      imageUrl: json['image'],
      createdAt:
          json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt:
          json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }
}
