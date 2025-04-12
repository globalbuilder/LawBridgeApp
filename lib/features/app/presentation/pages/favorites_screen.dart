import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../educational_opportunities/presentation/pages/educational_opportunities_favorites_screen.dart';
import '../../../legal_resources/presentation/pages/legal_resources_favorites_screen.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = '/favorites';

  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
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
        title: 'Favorites',
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
          EducationalOpportunitiesFavoritesScreen(),
          LegalResourcesFavoritesScreen(),
        ],
      ),
    );
  }
}
