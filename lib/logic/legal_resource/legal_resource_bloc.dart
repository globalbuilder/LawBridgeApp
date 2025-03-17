// lib/logic/legal_resource/legal_resource_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'legal_resource_event.dart';
import 'legal_resource_state.dart';
import '../../data/repositories/legal_resource_repository.dart';

class LegalResourceBloc extends Bloc<LegalResourceEvent, LegalResourceState> {
  final LegalResourceRepository repository;
  LegalResourceBloc({required this.repository}) : super(ResourceInitial()) {
    on<FetchAllResourcesEvent>(_onFetchAll);
    on<FetchResourceDetailEvent>(_onFetchDetail);
  }

  Future<void> _onFetchAll(
    FetchAllResourcesEvent event,
    Emitter<LegalResourceState> emit,
  ) async {
    emit(ResourcesLoading());
    try {
      final resources = await repository.fetchAllResources();
      emit(ResourcesLoaded(resources: resources));
    } catch (error) {
      emit(ResourceError(error: error.toString()));
    }
  }

  Future<void> _onFetchDetail(
    FetchResourceDetailEvent event,
    Emitter<LegalResourceState> emit,
  ) async {
    emit(ResourcesLoading());
    try {
      final resource = await repository.fetchResourceDetail(event.resourceId);
      emit(ResourceDetailLoaded(resource: resource));
    } catch (error) {
      emit(ResourceError(error: error.toString()));
    }
  }
}
