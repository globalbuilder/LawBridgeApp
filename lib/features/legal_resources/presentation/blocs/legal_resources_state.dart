import 'package:equatable/equatable.dart';
import '../../domain/entities/legal_resource_entity.dart';
import '../../domain/entities/favorite_resource_entity.dart';

enum ResStatus {
  initial,
  loadingList,
  loadingDetail,
  loadingFavs,
  loadedList,
  loadedDetail,
  updatingFav,
  error,
}

class LegalResourcesState extends Equatable {
  final ResStatus status;
  final List<LegalResourceEntity> resources;
  final LegalResourceEntity? resourceDetail;
  final List<FavoriteResourceEntity> favorites;
  final Set<int> favoriteIds;
  final String? errorMessage;

  const LegalResourcesState({
    this.status = ResStatus.initial,
    this.resources = const [],
    this.resourceDetail,
    this.favorites = const [],
    this.favoriteIds = const {},
    this.errorMessage,
  });

  LegalResourcesState copyWith({
    ResStatus? status,
    List<LegalResourceEntity>? resources,
    LegalResourceEntity? resourceDetail,
    List<FavoriteResourceEntity>? favorites,
    Set<int>? favoriteIds,
    String? errorMessage,
  }) {
    return LegalResourcesState(
      status: status ?? this.status,
      resources: resources ?? this.resources,
      resourceDetail: resourceDetail ?? this.resourceDetail,
      favorites: favorites ?? this.favorites,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, resources, resourceDetail, favorites, favoriteIds, errorMessage];
}
