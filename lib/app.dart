// lib/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Theme
import 'core/theme/theme_bloc.dart';

// Authentication
import 'logic/auth/auth_bloc.dart';
import 'data/data_providers/api_service.dart';
import 'data/repositories/auth_repository.dart';

// Profile Management
import 'data/repositories/profile_repository.dart';
import 'logic/profile/profile_bloc.dart';

// Legal Resources
import 'data/repositories/legal_resource_repository.dart';
import 'logic/legal_resource/legal_resource_bloc.dart';

// Routing
import 'router/app_router.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    // Instantiate our shared ApiService
    final apiService = ApiService();

    // Create repositories
    final authRepository = AuthRepository(apiService: apiService);
    final profileRepository = ProfileRepository(apiService: apiService);
    final legalResourceRepository =
        LegalResourceRepository(apiService: apiService);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
        BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(authRepository: authRepository)),
        BlocProvider<ProfileBloc>(
            create: (_) => ProfileBloc(profileRepository: profileRepository)),
        BlocProvider<LegalResourceBloc>(
            create: (_) =>
                LegalResourceBloc(repository: legalResourceRepository)),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'LawBridge App',
            theme: themeState.themeData,
            initialRoute: '/login',
            onGenerateRoute: _appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
