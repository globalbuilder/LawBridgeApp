// lib/presentation/screens/home/main_home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/auth/auth_bloc.dart';
import '../../../logic/auth/auth_event.dart';

// Your three tabs
import '../legal_resources/resource_list_screen.dart';
import '../educational_opportunities/education_opportunity_list_screen.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Welcome to LawBridge Dashboard!'),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    HomeDashboardScreen(),
    ResourceListScreen(),
    EducationOpportunityListScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Drawer items
  void _openProfile() {
    Navigator.pop(context); // close drawer
    Navigator.pushNamed(context, '/profile');
  }

  void _openFavorites() {
    Navigator.pop(context); // close drawer
    Navigator.pushNamed(context, '/favorites');
  }

  void _openSettings() {
    Navigator.pop(context);
    // Suppose you have a settings screen
    Navigator.pushNamed(context, '/settings');
  }

  void _logout() {
    context.read<AuthBloc>().add(LogoutRequested());
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _openNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notifications clicked')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LawBridge Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Notifications',
            onPressed: _openNotifications,
          ),
        ],
      ),
      // The Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('LawBridge Menu', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: _openProfile,
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: _openFavorites,
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: _openSettings,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel),
            label: 'Resources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Opportunities',
          ),
        ],
      ),
    );
  }
}
