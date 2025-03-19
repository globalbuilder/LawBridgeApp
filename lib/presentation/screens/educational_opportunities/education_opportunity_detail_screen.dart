// lib/presentation/screens/educational_opportunities/education_opportunity_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

// Auth
import '../../../logic/auth/auth_bloc.dart';
import '../../../logic/auth/auth_state.dart';

// Favorites
import '../../../logic/favorites/favorites_bloc.dart';
import '../../../logic/favorites/favorites_event.dart';

// Educational Opportunities BLoC
import '../../../logic/educational_opportunities/educational_opportunities_bloc.dart';
import '../../../logic/educational_opportunities/educational_opportunities_event.dart';
import '../../../logic/educational_opportunities/educational_opportunities_state.dart';

// ID storage
import 'education_opportunity_list_screen.dart' show OpportunityDetailArgs;

class EducationOpportunityDetailScreen extends StatefulWidget {
  const EducationOpportunityDetailScreen({Key? key}) : super(key: key);

  @override
  State<EducationOpportunityDetailScreen> createState() =>
      _EducationOpportunityDetailScreenState();
}

class _EducationOpportunityDetailScreenState
    extends State<EducationOpportunityDetailScreen> {
  int? _opportunityId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupDetailFetch();
    });
  }

  /// Load the ID from OpportunityDetailArgs, fetch the detail
  void _setupDetailFetch() {
    final id = OpportunityDetailArgs.opportunityId;
    if (id == null) {
      debugPrint('No opportunity ID found in OpportunityDetailArgs');
      return;
    }
    _opportunityId = id;
    context.read<EducationalOpportunitiesBloc>().add(
      FetchOpportunityDetailEvent(opportunityId: id),
    );
  }

  /// Toggle or add to favorite opportunity
  void _toggleFavoriteOpportunity() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to favorite opportunities')),
      );
      return;
    }
    final token = authState.accessToken;
    if (_opportunityId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No opportunity ID found.')),
      );
      return;
    }

    context.read<FavoritesBloc>().add(
      AddOpportunityFavoriteEvent(token: token, opportunityId: _opportunityId!),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opportunity favorited!')),
    );
  }

  Future<void> _openLink(String link) async {
    final uri = Uri.parse(link);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open link: $link')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opportunity Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: _toggleFavoriteOpportunity,
          ),
        ],
      ),
      body: BlocBuilder<EducationalOpportunitiesBloc, EducationalOpportunitiesState>(
        builder: (context, state) {
          if (state is OpportunitiesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OpportunityDetailLoaded) {
            final opp = state.opportunity;
            final title = opp['title'] as String? ?? 'No Title';
            final description = opp['description'] as String? ?? '';
            final startDate = opp['start_date'] as String? ?? '';
            final endDate = opp['end_date'] as String? ?? '';
            final location = opp['location'] as String? ?? '';
            final contactInfo = opp['contact_info'] as String? ?? '';
            final externalLink = opp['external_link'] as String?;
            final imageUrl = opp['image'] as String?;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Starts: $startDate'),
                  Text('Ends: $endDate'),
                  Text('Location: $location'),
                  const SizedBox(height: 8),
                  Text(description),
                  const SizedBox(height: 8),
                  Text('Contact: $contactInfo'),
                  const SizedBox(height: 16),
                  if (externalLink != null && externalLink.isNotEmpty)
                    ElevatedButton(
                      onPressed: () => _openLink(externalLink),
                      child: const Text('Open External Link'),
                    ),
                ],
              ),
            );
          } else if (state is OpportunityError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No details available'));
        },
      ),
    );
  }
}
