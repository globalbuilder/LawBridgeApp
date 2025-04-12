import '../../domain/entities/opportunity_entity.dart';

class OpportunityModel extends OpportunityEntity {
  const OpportunityModel({
    required super.id,
    required super.title,
    super.description,
    super.startDate,
    super.endDate,
    super.location,
    super.contactInfo,
    super.externalLink,
    super.image,
    super.createdAt,
    super.updatedAt,
  });

  factory OpportunityModel.fromJson(Map<String, dynamic> json) {
    return OpportunityModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'],
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      location: json['location'],
      contactInfo: json['contact_info'],
      externalLink: json['external_link'],
      image: json['image'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}
