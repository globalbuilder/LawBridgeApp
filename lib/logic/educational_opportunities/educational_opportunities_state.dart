// lib/logic/educational_opportunities/educational_opportunities_state.dart

import 'package:equatable/equatable.dart';

abstract class EducationalOpportunitiesState extends Equatable {
  const EducationalOpportunitiesState();

  @override
  List<Object?> get props => [];
}

class OpportunitiesInitial extends EducationalOpportunitiesState {}

/// While fetching the list or the detail
class OpportunitiesLoading extends EducationalOpportunitiesState {}

/// After fetching the entire list
class OpportunitiesLoaded extends EducationalOpportunitiesState {
  final List<Map<String, dynamic>> opportunities;
  const OpportunitiesLoaded({required this.opportunities});

  @override
  List<Object?> get props => [opportunities];
}

/// After fetching a single opportunity detail
class OpportunityDetailLoaded extends EducationalOpportunitiesState {
  final Map<String, dynamic> opportunity;
  const OpportunityDetailLoaded({required this.opportunity});

  @override
  List<Object?> get props => [opportunity];
}

class OpportunityError extends EducationalOpportunitiesState {
  final String error;
  const OpportunityError({required this.error});

  @override
  List<Object?> get props => [error];
}
