import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app_router.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../../../educational_opportunities/presentation/blocs/educational_opportunities_bloc.dart';
import '../../../educational_opportunities/presentation/blocs/educational_opportunities_event.dart';
import '../../../educational_opportunities/presentation/blocs/educational_opportunities_state.dart';
import '../widgets/educational_opportunities_widgets.dart';

class EducationalOpportunitiesScreen extends StatefulWidget {
  const EducationalOpportunitiesScreen({super.key});

  @override
  State<EducationalOpportunitiesScreen> createState() =>
      _EducationalOpportunitiesScreenState();
}

class _EducationalOpportunitiesScreenState
    extends State<EducationalOpportunitiesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EducationalOpportunitiesBloc>().add(const LoadOpportunities());
  }

  Future<void> _refresh() async {
    context.read<EducationalOpportunitiesBloc>().add(const LoadOpportunities());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationalOpportunitiesBloc,
        EducationalOpportunitiesState>(
      builder: (context, state) {
        if (state.status == EduStatus.loadingList) {
          return const CustomLoader();
        }
        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }
        return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: state.opportunities.length,
            itemBuilder: (ctx, i) {
              final opp = state.opportunities[i];
              return OpportunityCard(
                opportunity: opp,
                isFav: state.favoriteIds.contains(opp.id),
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
          ),
        );
      },
    );
  }
}
