

import 'package:equatable/equatable.dart';
import '../../domain/entities/opportunity_entity.dart';
import '../../domain/entities/favorite_opportunity_entity.dart';

enum EduStatus {
  initial,
  loadingList,
  loadingDetail,
  loadingFavs,
  loadedList,
  loadedDetail,
  updatingFav,
  error,
}

class EducationalOpportunitiesState extends Equatable {
  final EduStatus status;

  final List<OpportunityEntity> opportunities;

  final OpportunityEntity? opportunityDetail;

  final List<FavoriteOpportunityEntity> favorites;

  final Set<int> favoriteIds;

  final String? errorMessage;

  const EducationalOpportunitiesState({
    this.status = EduStatus.initial,
    this.opportunities = const [],
    this.opportunityDetail,
    this.favorites = const [],
    this.favoriteIds = const {},
    this.errorMessage,
  });

  EducationalOpportunitiesState copyWith({
    EduStatus? status, 
    List<OpportunityEntity>? opportunities,
    OpportunityEntity? opportunityDetail,
    List<FavoriteOpportunityEntity>? favorites,
    Set<int>? favoriteIds,
    String? errorMessage,
  }) {
    return EducationalOpportunitiesState(
      status: status ?? this.status,
      opportunities: opportunities ?? this.opportunities,
      opportunityDetail: opportunityDetail ?? this.opportunityDetail,
      favorites: favorites ?? this.favorites,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        opportunities,
        opportunityDetail,
        favorites,
        favoriteIds,
        errorMessage,
      ];
}
