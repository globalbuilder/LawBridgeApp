// lib/presentation/screens/educational_opportunities/education_opportunity_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/educational_opportunities/educational_opportunities_bloc.dart';
import '../../../logic/educational_opportunities/educational_opportunities_event.dart';
import '../../../logic/educational_opportunities/educational_opportunities_state.dart';

/// A simple static class to store the selected opportunity ID
class OpportunityDetailArgs {
  static int? opportunityId;
}

class EducationOpportunityListScreen extends StatefulWidget {
  const EducationOpportunityListScreen({Key? key}) : super(key: key);

  @override
  State<EducationOpportunityListScreen> createState() =>
      _EducationOpportunityListScreenState();
}

class _EducationOpportunityListScreenState
    extends State<EducationOpportunityListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch all opportunities
    context
        .read<EducationalOpportunitiesBloc>()
        .add(FetchAllOpportunitiesEvent());
  }

  void _navigateToDetail(int oppId) {
    OpportunityDetailArgs.opportunityId = oppId;
    Navigator.pushNamed(context, '/educationalopportunities/detail');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educational Opportunities'),
      ),
      body: BlocBuilder<EducationalOpportunitiesBloc,
          EducationalOpportunitiesState>(
        builder: (context, state) {
          if (state is OpportunitiesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OpportunitiesLoaded) {
            final opportunities = state.opportunities;
            return ListView.builder(
              itemCount: opportunities.length,
              itemBuilder: (context, index) {
                final item = opportunities[index];
                final id = item['id'] as int;
                final title = item['title'] as String? ?? 'No Title';
                final imageUrl = item['image'] as String?;

                return ListTile(
                  leading: imageUrl != null
                      ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                      : const Icon(Icons.image_not_supported),
                  title: Text(title),
                  onTap: () => _navigateToDetail(id),
                );
              },
            );
          } else if (state is OpportunityError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
