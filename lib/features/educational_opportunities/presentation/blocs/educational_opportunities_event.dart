

import 'package:equatable/equatable.dart';

abstract class EducationalOpportunitiesEvent extends Equatable {
  const EducationalOpportunitiesEvent();
  @override
  List<Object?> get props => [];
}

class LoadOpportunities extends EducationalOpportunitiesEvent {
  final String? query; 
  const LoadOpportunities({this.query});
  @override
  List<Object?> get props => [query];
}

class LoadOpportunityDetail extends EducationalOpportunitiesEvent {
  final int id;
  const LoadOpportunityDetail(this.id);
  @override
  List<Object?> get props => [id];
}

class LoadFavorites extends EducationalOpportunitiesEvent {
  const LoadFavorites();
}

class ToggleFavorite extends EducationalOpportunitiesEvent {
  final int id;
  const ToggleFavorite(this.id);
  @override
  List<Object?> get props => [id];
}
