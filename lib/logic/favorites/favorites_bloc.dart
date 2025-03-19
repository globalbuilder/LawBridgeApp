// lib/logic/favorites/favorites_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';
import '../../data/repositories/favorites_repository.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository repository;
  FavoritesBloc({required this.repository}) : super(FavoritesInitial()) {
    on<FetchAllFavoritesEvent>(_onFetchAll);
    on<AddResourceFavoriteEvent>(_onAddResourceFav);
    on<RemoveResourceFavoriteEvent>(_onRemoveResourceFav);
    on<AddOpportunityFavoriteEvent>(_onAddOppFav);
    on<RemoveOpportunityFavoriteEvent>(_onRemoveOppFav);
  }

  Future<void> _onFetchAll(
    FetchAllFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    try {
      final resourceFavs = await repository.getFavoriteResources(token: event.token);
      final oppFavs = await repository.getFavoriteOpportunities(token: event.token);
      emit(FavoritesLoaded(
        resourceFavorites: resourceFavs,
        opportunityFavorites: oppFavs,
      ));
    } catch (error) {
      emit(FavoritesError(error: error.toString()));
    }
  }

  Future<void> _onAddResourceFav(
    AddResourceFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      // We can do an immediate call to add
      await repository.addResourceFavorite(
        token: event.token,
        resourceId: event.resourceId,
      );
      // Optionally re-fetch
    } catch (error) {
      emit(FavoritesError(error: error.toString()));
    }
  }

  Future<void> _onRemoveResourceFav(
    RemoveResourceFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await repository.removeResourceFavorite(
        token: event.token,
        favoriteId: event.favoriteId,
      );
      // Optionally re-fetch
    } catch (error) {
      emit(FavoritesError(error: error.toString()));
    }
  }

  Future<void> _onAddOppFav(
    AddOpportunityFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await repository.addOpportunityFavorite(
        token: event.token,
        opportunityId: event.opportunityId,
      );
      // Optionally re-fetch
    } catch (error) {
      emit(FavoritesError(error: error.toString()));
    }
  }

  Future<void> _onRemoveOppFav(
    RemoveOpportunityFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await repository.removeOpportunityFavorite(
        token: event.token,
        favoriteId: event.favoriteId,
      );
      // Optionally re-fetch
    } catch (error) {
      emit(FavoritesError(error: error.toString()));
    }
  }
}
