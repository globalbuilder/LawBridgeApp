// lib/presentation/screens/favorites/favorites_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/favorites/favorites_bloc.dart';
import '../../../logic/favorites/favorites_event.dart';
import '../../../logic/favorites/favorites_state.dart';
import '../../../logic/auth/auth_bloc.dart';
import '../../../logic/auth/auth_state.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        context.read<FavoritesBloc>().add(FetchAllFavoritesEvent(token: authState.accessToken));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Favorites')),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesLoaded) {
            final resourceFavs = state.resourceFavorites;
            final oppFavs = state.opportunityFavorites;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Favorite Resources', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  if (resourceFavs.isEmpty)
                    const Text('No favorite resources'),
                  for (var fav in resourceFavs)
                    ListTile(
                      title: Text('Resource ID: ${fav["resource"]}'),
                      subtitle: Text('Favorite ID: ${fav["id"]}'),
                      // On tap you could open the detail screen if you want
                    ),
                  const SizedBox(height: 24),
                  const Text('Favorite Opportunities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  if (oppFavs.isEmpty)
                    const Text('No favorite opportunities'),
                  for (var fav in oppFavs)
                    ListTile(
                      title: Text('Opportunity ID: ${fav["opportunity"]}'),
                      subtitle: Text('Favorite ID: ${fav["id"]}'),
                    ),
                ],
              ),
            );
          } else if (state is FavoritesError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
