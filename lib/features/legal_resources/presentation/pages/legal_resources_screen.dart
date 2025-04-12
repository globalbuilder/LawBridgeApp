import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../../../../app_router.dart';
import '../blocs/legal_resources_bloc.dart';
import '../blocs/legal_resources_event.dart';
import '../blocs/legal_resources_state.dart';
import '../widgets/legal_resources_widgets.dart';

class LegalResourcesScreen extends StatefulWidget {
  const LegalResourcesScreen({super.key});

  @override
  State<LegalResourcesScreen> createState() => _LegalResourcesScreenState();
}

class _LegalResourcesScreenState extends State<LegalResourcesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LegalResourcesBloc>().add(const LoadResources());
  }

  Future<void> _refresh() async {
    context.read<LegalResourcesBloc>().add(const LoadResources());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LegalResourcesBloc, LegalResourcesState>(
      builder: (context, state) {
        if (state.status == ResStatus.loadingList) {
          return const CustomLoader();
        }
        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }
        return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
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
          ),
        );
      },
    );
  }
}
