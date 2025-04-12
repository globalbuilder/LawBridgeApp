// lib/features/legal_resources/domain/entities/legal_resource_entity.dart
class LegalResourceEntity {
  final int id;
  final String title;
  final String? description;
  final String? fileUrl;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const LegalResourceEntity({
    required this.id,
    required this.title,
    this.description,
    this.fileUrl,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });
}
