import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../../../../app_router.dart';
import '../blocs/legal_resources_bloc.dart';
import '../blocs/legal_resources_event.dart';
import '../blocs/legal_resources_state.dart';
import '../widgets/legal_resources_widgets.dart';

class LegalResourcesFavoritesScreen extends StatefulWidget {
  const LegalResourcesFavoritesScreen({super.key});

  @override
  State<LegalResourcesFavoritesScreen> createState() =>
      _LegalResourcesFavoritesScreenState();
}

class _LegalResourcesFavoritesScreenState
    extends State<LegalResourcesFavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LegalResourcesBloc>().add(const LoadResourceFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LegalResourcesBloc, LegalResourcesState>(
      builder: (context, state) {
        if (state.status == ResStatus.loadingFavs) {
          return const CustomLoader();
        }
        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }

        // Only show items whose IDs are still in favouriteIds
        final visible = state.favorites
            .where((f) => state.favoriteIds.contains(f.resource.id))
            .toList();

        if (visible.isEmpty) {
          return const Center(child: Text('No favourites yet.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 80),
          itemCount: visible.length,
          itemBuilder: (_, i) {
            final res = visible[i].resource;
            return ResourceCard(
              resource: res,
              isFav: true,
              onFavTap: () => context
                  .read<LegalResourcesBloc>()
                  .add(ToggleFavoriteResource(res.id)),
              onOpen: () => Navigator.pushNamed(
                context,
                AppRouter.resourceDetail,
                arguments: res.id,
              ),
            );
          },
        );
      },
    );
  }
}
