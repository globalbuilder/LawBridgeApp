// lib/features/legal_resources/domain/entities/favorite_resource_entity.dart
import 'legal_resource_entity.dart';

class FavoriteResourceEntity {
  final int id;
  final LegalResourceEntity resource;
  final DateTime favoritedAt;

  const FavoriteResourceEntity({
    required this.id,
    required this.resource,
    required this.favoritedAt,
  });
}
