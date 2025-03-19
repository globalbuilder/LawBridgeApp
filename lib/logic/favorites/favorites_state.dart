// lib/logic/favorites/favorites_state.dart

import 'package:equatable/equatable.dart';

/// We'll store lists of resource favorites and opportunity favorites
/// Each favorite object might look like { "id": 5, "resource": 2, ... }
/// or { "id": 10, "opportunity": 3, ... } depending on the backend.

abstract class FavoritesState extends Equatable {
  const FavoritesState();
  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Map<String, dynamic>> resourceFavorites; 
  final List<Map<String, dynamic>> opportunityFavorites;

  const FavoritesLoaded({
    required this.resourceFavorites,
    required this.opportunityFavorites,
  });

  @override
  List<Object?> get props => [resourceFavorites, opportunityFavorites];
}

class FavoritesError extends FavoritesState {
  final String error;
  const FavoritesError({required this.error});
  @override
  List<Object?> get props => [error];
}
