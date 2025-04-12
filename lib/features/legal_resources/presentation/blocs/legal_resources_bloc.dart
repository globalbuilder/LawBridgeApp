import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/legal_resource_entity.dart';
import '../../domain/repositories/legal_resources_repository.dart';
import 'legal_resources_event.dart';
import 'legal_resources_state.dart';

class LegalResourcesBloc
    extends Bloc<LegalResourcesEvent, LegalResourcesState> {
  final LegalResourcesRepository repo;

  LegalResourcesBloc({required this.repo})
      : super(const LegalResourcesState()) {
    on<LoadResources>(_onLoadResources);
    on<LoadResourceDetail>(_onLoadDetail);
    on<LoadResourceFavorites>(_onLoadFavorites);
    on<ToggleFavoriteResource>(_onToggleFavorite);
  }

  Future<void> _onLoadResources(
      LoadResources e, Emitter<LegalResourcesState> emit) async {
    emit(state.copyWith(status: ResStatus.loadingList, errorMessage: null));

    final Either<Failure, List<LegalResourceEntity>> res =
        await repo.getResources(search: e.query);

    await res.fold(
      (f) async =>
          emit(state.copyWith(status: ResStatus.error, errorMessage: f.message)),
      (list) async {
        // refresh favourites to sync icons
        final favRes = await repo.getFavoriteResources();
        favRes.fold(
          (f) => emit(state.copyWith(
              status: ResStatus.loadedList,
              resources: list,
              errorMessage: f.message)),
          (favList) => emit(state.copyWith(
            status: ResStatus.loadedList,
            resources: list,
            favorites: favList,
            favoriteIds: favList.map((f) => f.resource.id).toSet(),
          )),
        );
      },
    );
  }

  Future<void> _onLoadDetail(
      LoadResourceDetail e, Emitter<LegalResourcesState> emit) async {
    emit(state.copyWith(status: ResStatus.loadingDetail, errorMessage: null));

    final res = await repo.getResourceDetail(e.id);
    res.fold(
      (f) =>
          emit(state.copyWith(status: ResStatus.error, errorMessage: f.message)),
      (resource) => emit(state.copyWith(
        status: ResStatus.loadedDetail,
        resourceDetail: resource,
      )),
    );
  }

  Future<void> _onLoadFavorites(
      LoadResourceFavorites e, Emitter<LegalResourcesState> emit) async {
    emit(state.copyWith(status: ResStatus.loadingFavs, errorMessage: null));

    final res = await repo.getFavoriteResources();
    res.fold(
      (f) =>
          emit(state.copyWith(status: ResStatus.error, errorMessage: f.message)),
      (favList) => emit(state.copyWith(
        status: ResStatus.loadedList,
        favorites: favList,
        favoriteIds: favList.map((f) => f.resource.id).toSet(),
      )),
    );
  }

  Future<void> _onToggleFavorite(
      ToggleFavoriteResource e, Emitter<LegalResourcesState> emit) async {
    final alreadyFav = state.favoriteIds.contains(e.id);

    // optimistic flip
    final updatedIds = {...state.favoriteIds};
    if (alreadyFav) {
      updatedIds.remove(e.id);
    } else {
      updatedIds.add(e.id);
    }
    emit(state.copyWith(
        favoriteIds: updatedIds, status: ResStatus.updatingFav));

    final Either<Failure, void> res = alreadyFav
        ? await repo.removeFavoriteResource(e.id)
        : await repo.addFavoriteResource(e.id);

    res.fold(
      (f) {
        // rollback
        if (alreadyFav) {
          updatedIds.add(e.id);
        } else {
          updatedIds.remove(e.id);
        }
        emit(state.copyWith(
            favoriteIds: updatedIds,
            status: ResStatus.error,
            errorMessage: f.message));
      },
      (_) => emit(state.copyWith(
          status: state.resourceDetail != null
              ? ResStatus.loadedDetail
              : ResStatus.loadedList)),
    );
  }
}
