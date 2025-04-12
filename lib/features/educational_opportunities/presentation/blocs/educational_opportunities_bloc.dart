
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/opportunity_entity.dart';
import '../../domain/repositories/educational_opportunities_repository.dart';
import '../../../../core/errors/failure.dart';

import 'educational_opportunities_event.dart';
import 'educational_opportunities_state.dart';

class EducationalOpportunitiesBloc extends Bloc<
    EducationalOpportunitiesEvent, EducationalOpportunitiesState> {
  final EducationalOpportunitiesRepository repo;

  EducationalOpportunitiesBloc({required this.repo})
      : super(const EducationalOpportunitiesState()) {
    on<LoadOpportunities>(_onLoadOpportunities);
    on<LoadOpportunityDetail>(_onLoadDetail);
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadOpportunities(LoadOpportunities event,
      Emitter<EducationalOpportunitiesState> emit) async {
    emit(state.copyWith(status: EduStatus.loadingList, errorMessage: null));

    final Either<Failure, List<OpportunityEntity>> res =
        await repo.getOpportunities(search: event.query);

    await res.fold(
      (f) async => emit(
          state.copyWith(status: EduStatus.error, errorMessage: f.message)),
      (list) async {
        // refresh favourites so icons are correct
        final favRes = await repo.getFavoriteOpportunities();
        favRes.fold(
          (f) => emit(state.copyWith(
              status: EduStatus.loadedList,
              opportunities: list,
              errorMessage: f.message)),
          (favList) => emit(state.copyWith(
            status: EduStatus.loadedList,
            opportunities: list,
            favorites: favList,
            favoriteIds: favList.map((f) => f.opportunity.id).toSet(),
          )),
        );
      },
    );
  }

  Future<void> _onLoadDetail(LoadOpportunityDetail event,
      Emitter<EducationalOpportunitiesState> emit) async {
    emit(state.copyWith(status: EduStatus.loadingDetail, errorMessage: null));

    final res = await repo.getOpportunityDetail(event.id);
    res.fold(
      (f) =>
          emit(state.copyWith(status: EduStatus.error, errorMessage: f.message)),
      (opp) => emit(state.copyWith(
        status: EduStatus.loadedDetail,
        opportunityDetail: opp,
      )),
    );
  }

  Future<void> _onLoadFavorites(
      LoadFavorites event, Emitter<EducationalOpportunitiesState> emit) async {
    emit(state.copyWith(status: EduStatus.loadingFavs, errorMessage: null));

    final res = await repo.getFavoriteOpportunities();
    res.fold(
      (f) =>
          emit(state.copyWith(status: EduStatus.error, errorMessage: f.message)),
      (favList) => emit(state.copyWith(
        status: EduStatus.loadedList,
        favorites: favList,
        favoriteIds: favList.map((f) => f.opportunity.id).toSet(),
      )),
    );
  }

  Future<void> _onToggleFavorite(
      ToggleFavorite event, Emitter<EducationalOpportunitiesState> emit) async {
    final alreadyFav = state.favoriteIds.contains(event.id);

    final updatedIds = {...state.favoriteIds};
    if (alreadyFav) {
      updatedIds.remove(event.id);
    } else {
      updatedIds.add(event.id);
    }
    emit(state.copyWith(
        favoriteIds: updatedIds, status: EduStatus.updatingFav));

    final Either<Failure, void> res = alreadyFav
        ? await repo.removeFavoriteOpportunity(event.id)
        : await repo.addFavoriteOpportunity(event.id);

    res.fold(
      (f) {
        if (alreadyFav) {
          updatedIds.add(event.id);
        } else {
          updatedIds.remove(event.id);
        }
        emit(state.copyWith(
            favoriteIds: updatedIds,
            status: EduStatus.error,
            errorMessage: f.message));
      },
      (_) => emit(state.copyWith(
          status: state.opportunityDetail != null
              ? EduStatus.loadedDetail
              : EduStatus.loadedList)),
    );
  }
}
