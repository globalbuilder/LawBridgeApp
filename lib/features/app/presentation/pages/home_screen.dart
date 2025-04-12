import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_router.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';
import '../../../../core/widgets/exit_confirmation.dart';
import '../../../accounts/presentation/blocs/accounts_bloc.dart';
import '../../../accounts/presentation/blocs/accounts_event.dart';
import '../../../accounts/presentation/blocs/accounts_state.dart';
import '../../../educational_opportunities/presentation/pages/educational_opportunities_screen.dart';
import '../../../legal_resources/presentation/pages/legal_resources_screen.dart';
import '../../../notifications/presentation/blocs/notifications_bloc.dart';
import '../../../notifications/presentation/blocs/notifications_event.dart';
import '../../../notifications/presentation/blocs/notifications_state.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // The two tabs: Opportunities & LegalResources
  final List<Widget> _pages = const [
    EducationalOpportunitiesScreen(),
    LegalResourcesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Load user data
    context.read<AccountsBloc>().add(FetchUserInfoEvent());
    // Load notifications for the badge
    context.read<NotificationsBloc>().add(const LoadNotifications());
  }

  // Confirmation before closing the app
  Future<bool> _onWillPop() async {
    final shouldExit = await showExitConfirmationDialog(context);
    if (shouldExit) exitApp();
    return false;
  }

  // Called by the pull-to-refresh gesture
  Future<void> _pullToRefresh() async {
    // Re-fetch notifications to update the badge
    context.read<NotificationsBloc>().add(const LoadNotifications());
    // we can also refresh the user or other data here:
    // context.read<AccountsBloc>().add(FetchUserInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'LawBridge',
          actions: [
            // Search icon
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => Navigator.pushNamed(context, AppRouter.search),
            ),
            // Notifications icon with a badge on top
            BlocBuilder<NotificationsBloc, NotificationsState>(
              builder: (_, state) {
                final unread = state.unreadCount;
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/notifications'),
                    ),
                    if (unread > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            unread > 9 ? '9+' : '$unread',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
        // The navigation drawer
        drawer: BlocBuilder<AccountsBloc, AccountsState>(
          builder: (_, state) => CustomDrawer(
            username: state.user?.username ?? '',
            email: state.user?.email ?? '',
            profileImageUrl: state.user?.imageUrl ?? '',
            onLogout: () {
              context.read<AccountsBloc>().add(LogoutEvent());
              Navigator.pushReplacementNamed(context, AppRouter.login);
            },
          ),
        ),
        // The body with pull-to-refresh
        body: RefreshIndicator(
          onRefresh: _pullToRefresh,
          child: _pages[_currentIndex],
        ),
        bottomNavigationBar: CustomBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: "Opportunities",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: "Legal Resources",
            ),
          ],
        ),
      ),
    );
  }
}
