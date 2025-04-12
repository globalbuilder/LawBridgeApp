import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../blocs/educational_opportunities_bloc.dart';
import '../blocs/educational_opportunities_event.dart';
import '../blocs/educational_opportunities_state.dart';

class EducationalOpportunityDetailScreen extends StatefulWidget {
  static const routeName = '/opportunity/detail';
  final int id;
  const EducationalOpportunityDetailScreen({super.key, required this.id});

  @override
  State<EducationalOpportunityDetailScreen> createState() =>
      _EducationalOpportunityDetailScreenState();
}

class _EducationalOpportunityDetailScreenState
    extends State<EducationalOpportunityDetailScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<EducationalOpportunitiesBloc>()
        .add(LoadOpportunityDetail(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat.yMMMMd();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Opportunity Detail'),
      body: BlocBuilder<EducationalOpportunitiesBloc,
          EducationalOpportunitiesState>(
        builder: (context, state) {
          if (state.status == EduStatus.loadingDetail ||
              state.opportunityDetail == null) {
            return const CustomLoader();
          }
          final opp = state.opportunityDetail!;
          final isFav = state.favoriteIds.contains(opp.id);

          return Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  Hero(
                    tag: 'opportunity-img-${opp.id}',
                    child: opp.image != null
                        ? Image.network(opp.image!,
                            height: 240, width: double.infinity, fit: BoxFit.cover)
                        : Container(
                            height: 240,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.15),
                            child: const Icon(Icons.school, size: 80),
                          ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          opp.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        if (opp.startDate != null)
                          Row(
                            children: [
                              const Icon(Icons.calendar_month, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                '${dateFmt.format(opp.startDate!)}'
                                '${opp.endDate != null ? '  →  ${dateFmt.format(opp.endDate!)}' : ''}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (opp.location != null && opp.location!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on, size: 18),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    opp.location!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const Divider(height: 24),
                        if (opp.description != null && opp.description!.isNotEmpty)
                          Text(
                            opp.description!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        const SizedBox(height: 24),
                        if (opp.externalLink != null &&
                            opp.externalLink!.isNotEmpty)
                          CustomButton(
                            label: 'Open External Link',
                            onPressed: () {
                              // use url_launcher
                              // launchUrl(Uri.parse(opp.externalLink!));
                            },
                          ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
              // favourite floating button with scale animation
              Positioned(
                bottom: 24,
                right: 24,
                child: FloatingActionButton(
                  heroTag: 'fav-btn-${opp.id}',
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  onPressed: () => context
                      .read<EducationalOpportunitiesBloc>()
                      .add(ToggleFavorite(opp.id)),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, anim) =>
                        ScaleTransition(scale: anim, child: child),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey(isFav),
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
