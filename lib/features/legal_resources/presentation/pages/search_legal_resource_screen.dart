import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../../../../app_router.dart';
import '../blocs/legal_resources_bloc.dart';
import '../blocs/legal_resources_event.dart';
import '../blocs/legal_resources_state.dart';
import '../widgets/legal_resources_widgets.dart';

class SearchLegalResourceScreen extends StatefulWidget {
  const SearchLegalResourceScreen({super.key});

  @override
  State<SearchLegalResourceScreen> createState() =>
      _SearchLegalResourceScreenState();
}

class _SearchLegalResourceScreenState
    extends State<SearchLegalResourceScreen> {
  final _controller = TextEditingController();
  String _lastQuery = '';

  void _search(String q) {
    final trimmed = q.trim();
    if (trimmed == _lastQuery) return;
    _lastQuery = trimmed;
    context
        .read<LegalResourcesBloc>()
        .add(LoadResources(query: trimmed.isEmpty ? null : trimmed));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TextField(
            controller: _controller,
            onChanged: _search,
            decoration: InputDecoration(
              hintText: 'Search legal resources',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: theme.colorScheme.surface.withOpacity(0.1),
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
          ),
        ),
        Expanded(
          child: BlocBuilder<LegalResourcesBloc, LegalResourcesState>(
            builder: (context, state) {
              if (state.status == ResStatus.loadingList) {
                return const CustomLoader();
              }
              if (state.errorMessage != null) {
                return Center(child: Text(state.errorMessage!));
              }
              if (state.resources.isEmpty) {
                return const Center(child: Text('No results.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 80),
                itemCount: state.resources.length,
                itemBuilder: (_, i) {
                  final res = state.resources[i];
                  return ResourceCard(
                    resource: res,
                    isFav: state.favoriteIds.contains(res.id),
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
          ),
        ),
      ],
    );
  }
}
