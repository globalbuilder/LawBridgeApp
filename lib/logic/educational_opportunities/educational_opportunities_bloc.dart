// lib/logic/educational_opportunities/educational_opportunities_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'educational_opportunities_event.dart';
import 'educational_opportunities_state.dart';
import '../../data/repositories/educational_opportunities_repository.dart';

class EducationalOpportunitiesBloc
    extends Bloc<EducationalOpportunitiesEvent, EducationalOpportunitiesState> {
  final EducationalOpportunitiesRepository repository;

  EducationalOpportunitiesBloc({required this.repository})
      : super(OpportunitiesInitial()) {
    on<FetchAllOpportunitiesEvent>(_onFetchAll);
    on<FetchOpportunityDetailEvent>(_onFetchDetail);
  }

  Future<void> _onFetchAll(
    FetchAllOpportunitiesEvent event,
    Emitter<EducationalOpportunitiesState> emit,
  ) async {
    emit(OpportunitiesLoading());
    try {
      final opportunities = await repository.fetchAllOpportunities();
      emit(OpportunitiesLoaded(opportunities: opportunities));
    } catch (error) {
      emit(OpportunityError(error: error.toString()));
    }
  }

  Future<void> _onFetchDetail(
    FetchOpportunityDetailEvent event,
    Emitter<EducationalOpportunitiesState> emit,
  ) async {
    emit(OpportunitiesLoading());
    try {
      final opp = await repository.fetchOpportunityDetail(event.opportunityId);
      emit(OpportunityDetailLoaded(opportunity: opp));
    } catch (error) {
      emit(OpportunityError(error: error.toString()));
    }
  }
}
