// lib/logic/favorites/favorites_event.dart

import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override
  List<Object?> get props => [];
}

/// List all favorites (resources + opportunities)
class FetchAllFavoritesEvent extends FavoritesEvent {
  final String token;
  const FetchAllFavoritesEvent({required this.token});
  @override
  List<Object?> get props => [token];
}

/// Add a favorite resource
class AddResourceFavoriteEvent extends FavoritesEvent {
  final String token;
  final int resourceId;
  const AddResourceFavoriteEvent({required this.token, required this.resourceId});
  @override
  List<Object?> get props => [token, resourceId];
}

/// Remove a favorite resource
class RemoveResourceFavoriteEvent extends FavoritesEvent {
  final String token;
  final int favoriteId;
  const RemoveResourceFavoriteEvent({required this.token, required this.favoriteId});
  @override
  List<Object?> get props => [token, favoriteId];
}

/// Add a favorite opportunity
class AddOpportunityFavoriteEvent extends FavoritesEvent {
  final String token;
  final int opportunityId;
  const AddOpportunityFavoriteEvent({required this.token, required this.opportunityId});
  @override
  List<Object?> get props => [token, opportunityId];
}

/// Remove a favorite opportunity
class RemoveOpportunityFavoriteEvent extends FavoritesEvent {
  final String token;
  final int favoriteId;
  const RemoveOpportunityFavoriteEvent({required this.token, required this.favoriteId});
  @override
  List<Object?> get props => [token, favoriteId];
}
