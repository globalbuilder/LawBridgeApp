class OpportunityEntity {
  final int id;
  final String title;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? location;
  final String? contactInfo;
  final String? externalLink;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OpportunityEntity({
    required this.id,
    required this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.location,
    this.contactInfo,
    this.externalLink,
    this.image,
    this.createdAt,
    this.updatedAt,
  });
}
