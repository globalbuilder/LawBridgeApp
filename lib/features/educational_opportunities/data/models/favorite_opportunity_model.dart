import '../../domain/entities/favorite_opportunity_entity.dart';
import 'opportunity_model.dart';

class FavoriteOpportunityModel extends FavoriteOpportunityEntity {
  const FavoriteOpportunityModel({
    required super.id,
    required super.opportunity,
    required super.favoritedAt,
  });

  factory FavoriteOpportunityModel.fromJson(Map<String, dynamic> json) {
    return FavoriteOpportunityModel(
      id: json['id'],
      opportunity: OpportunityModel.fromJson(json['opportunity']),
      favoritedAt: DateTime.parse(json['favorited_at']),
    );
  }
}
