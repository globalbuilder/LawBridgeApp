// lib/app.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Blocs
import 'core/theme/theme_bloc.dart';
import 'logic/auth/auth_bloc.dart';
import 'logic/auth/auth_state.dart';
import 'logic/favorites/favorites_bloc.dart';
import 'logic/profile/profile_bloc.dart';
import 'logic/legal_resource/legal_resource_bloc.dart';
import 'logic/educational_opportunities/educational_opportunities_bloc.dart';

// Repositories
import 'data/data_providers/api_service.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/favorites_repository.dart';
import 'data/repositories/profile_repository.dart';
import 'data/repositories/legal_resource_repository.dart';
import 'data/repositories/educational_opportunities_repository.dart';

// Router
import 'router/app_router.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    // Instantiate one ApiService used by all Repositories
    final apiService = ApiService();

    // Create Repositories
    final authRepository = AuthRepository(apiService: apiService);
    final profileRepository = ProfileRepository(apiService: apiService);
    final favoritesRepository = FavoritesRepository(apiService: apiService);
    final legalResourceRepository = LegalResourceRepository(apiService: apiService);
    final educationalRepository = EducationalOpportunitiesRepository(apiService: apiService);

    return MultiBlocProvider(
      providers: [
        // Theme bloc if you have a theming approach
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),

        // Auth bloc
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authRepository: authRepository),
        ),

        // Favorites bloc
        BlocProvider<FavoritesBloc>(
          create: (_) => FavoritesBloc(repository: favoritesRepository),
        ),

        // Profile bloc
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(profileRepository: profileRepository),
        ),

        // Legal resource bloc
        BlocProvider<LegalResourceBloc>(
          create: (_) => LegalResourceBloc(repository: legalResourceRepository),
        ),

        // Educational opportunities bloc
        BlocProvider<EducationalOpportunitiesBloc>(
          create: (_) => EducationalOpportunitiesBloc(repository: educationalRepository),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'LawBridge App',
            debugShowCheckedModeBanner: false,
            theme: themeState.themeData,
            // e.g. initialRoute could be '/login'
            initialRoute: '/login',
            onGenerateRoute: _appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
