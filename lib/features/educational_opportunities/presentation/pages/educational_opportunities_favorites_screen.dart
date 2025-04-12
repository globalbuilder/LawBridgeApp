import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../../../../app_router.dart';
import '../blocs/educational_opportunities_bloc.dart';
import '../blocs/educational_opportunities_event.dart';
import '../blocs/educational_opportunities_state.dart';
import '../widgets/educational_opportunities_widgets.dart';

class EducationalOpportunitiesFavoritesScreen extends StatefulWidget {
  const EducationalOpportunitiesFavoritesScreen({super.key});

  @override
  State<EducationalOpportunitiesFavoritesScreen> createState() =>
      _EducationalOpportunitiesFavoritesScreenState();
}

class _EducationalOpportunitiesFavoritesScreenState
    extends State<EducationalOpportunitiesFavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EducationalOpportunitiesBloc>().add(const LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationalOpportunitiesBloc,
        EducationalOpportunitiesState>(
      builder: (context, state) {
        final visible = state.favorites
            .where((f) => state.favoriteIds.contains(f.opportunity.id))
            .toList();
            
        if (state.status == EduStatus.loadingFavs) {
          return const CustomLoader();
        }
        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }
        if (visible.isEmpty) {
          return const Center(child: Text('No favourites yet.'));
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 80),
          itemCount: visible.length,
          itemBuilder: (ctx, i) {
            final fav = visible[i];
            final opp = fav.opportunity;
            return OpportunityCard(
              opportunity: opp,
              isFav: true,
              onFavTap: () => context
                  .read<EducationalOpportunitiesBloc>()
                  .add(ToggleFavorite(opp.id)),
              onOpen: () => Navigator.pushNamed(
                context,
                AppRouter.opportunityDetail,
                arguments: opp.id,
              ),
            );
          },
        );
      },
    );
  }
}
