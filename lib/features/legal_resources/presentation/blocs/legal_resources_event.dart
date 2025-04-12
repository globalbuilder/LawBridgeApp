import 'package:equatable/equatable.dart';

abstract class LegalResourcesEvent extends Equatable {
  const LegalResourcesEvent();
  @override
  List<Object?> get props => [];
}

/// Load list (optional search query)
class LoadResources extends LegalResourcesEvent {
  final String? query;
  const LoadResources({this.query});
  @override
  List<Object?> get props => [query];
}

/// Fetch single resource (detail page)
class LoadResourceDetail extends LegalResourcesEvent {
  final int id;
  const LoadResourceDetail(this.id);
  @override
  List<Object?> get props => [id];
}

/// Load favourites list
class LoadResourceFavorites extends LegalResourcesEvent {
  const LoadResourceFavorites();
}

/// Add / remove favourite (optimistic)
class ToggleFavoriteResource extends LegalResourcesEvent {
  final int id;
  const ToggleFavoriteResource(this.id);
  @override
  List<Object?> get props => [id];
}
