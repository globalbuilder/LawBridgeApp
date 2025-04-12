import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../../../../app_router.dart';
import '../blocs/educational_opportunities_bloc.dart';
import '../blocs/educational_opportunities_event.dart';
import '../blocs/educational_opportunities_state.dart';
import '../widgets/educational_opportunities_widgets.dart';

class SearchEducationalOpportunityScreen extends StatefulWidget {
  const SearchEducationalOpportunityScreen({super.key});

  @override
  State<SearchEducationalOpportunityScreen> createState() =>
      _SearchEducationalOpportunityScreenState();
}

class _SearchEducationalOpportunityScreenState
    extends State<SearchEducationalOpportunityScreen> {
  final TextEditingController _controller = TextEditingController();
  String _lastQuery = '';

  /// Called when the search field changes.
  void _search(String q) {
    final trimmed = q.trim();
    if (trimmed == _lastQuery) return;
    _lastQuery = trimmed;
    context.read<EducationalOpportunitiesBloc>().add(
          LoadOpportunities(query: trimmed.isEmpty ? null : trimmed),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Search field with modern styling
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TextField(
            controller: _controller,
            onChanged: _search,
            decoration: InputDecoration(
              hintText: 'Search by title',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: theme.colorScheme.surface.withOpacity(0.8),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(color: theme.colorScheme.primary, width: 2),
              ),
            ),
            style: theme.textTheme.bodyMedium,
          ),
        ),
        // The opportunity list
        Expanded(
          child: BlocBuilder<EducationalOpportunitiesBloc,
              EducationalOpportunitiesState>(
            builder: (context, state) {
              if (state.status == EduStatus.loadingList) {
                return const CustomLoader();
              }
              if (state.errorMessage != null) {
                return Center(child: Text(state.errorMessage!));
              }
              if (state.opportunities.isEmpty) {
                return const Center(child: Text('No results.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 80),
                itemCount: state.opportunities.length,
                itemBuilder: (ctx, i) {
                  final opportunity = state.opportunities[i];
                  return OpportunityCard(
                    opportunity: opportunity,
                    isFav: state.favoriteIds.contains(opportunity.id),
                    onFavTap: () => context
                        .read<EducationalOpportunitiesBloc>()
                        .add(ToggleFavorite(opportunity.id)),
                    onOpen: () => Navigator.pushNamed(
                      context,
                      AppRouter.opportunityDetail,
                      arguments: opportunity.id,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
