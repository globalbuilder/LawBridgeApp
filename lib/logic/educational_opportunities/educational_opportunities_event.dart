// lib/logic/educational_opportunities/educational_opportunities_event.dart

import 'package:equatable/equatable.dart';

abstract class EducationalOpportunitiesEvent extends Equatable {
  const EducationalOpportunitiesEvent();

  @override
  List<Object?> get props => [];
}

/// List all educational opportunities
class FetchAllOpportunitiesEvent extends EducationalOpportunitiesEvent {}

/// Get detail for one opportunity
class FetchOpportunityDetailEvent extends EducationalOpportunitiesEvent {
  final int opportunityId;
  const FetchOpportunityDetailEvent({required this.opportunityId});

  @override
  List<Object?> get props => [opportunityId];
}
