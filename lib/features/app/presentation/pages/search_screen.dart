import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../educational_opportunities/presentation/pages/search_educational_opportunity_screen.dart';
import '../../../legal_resources/presentation/pages/search_legal_resource_screen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Search',
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Opportunities'),
            Tab(text: 'Legal Resources'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          SearchEducationalOpportunityScreen(),
          SearchLegalResourceScreen(),
        ],
      ),
    );
  }
}
