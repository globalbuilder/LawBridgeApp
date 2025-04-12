import 'opportunity_entity.dart';

class FavoriteOpportunityEntity {
  final int id;
  final OpportunityEntity opportunity;
  final DateTime favoritedAt;

  const FavoriteOpportunityEntity({
    required this.id,
    required this.opportunity,
    required this.favoritedAt,
  });
}
