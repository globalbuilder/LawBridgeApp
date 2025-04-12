import '../../domain/entities/favorite_resource_entity.dart';
import 'legal_resource_model.dart';

class FavoriteResourceModel extends FavoriteResourceEntity {
  const FavoriteResourceModel({
    required super.id,
    required super.resource,
    required super.favoritedAt,
  });

  factory FavoriteResourceModel.fromJson(Map<String, dynamic> json) {
    return FavoriteResourceModel(
      id: json['id'],
      resource: LegalResourceModel.fromJson(json['resource']),
      favoritedAt: DateTime.parse(json['favorited_at']),
    );
  }
}
