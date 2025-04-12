import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

// ─── Core ─────────────────────────────────────────────────────────────
import 'core/utils/api_client.dart';
import 'core/utils/preferences_helper.dart';
import 'core/theme/theme_manager.dart';

// ─── Accounts ─────────────────────────────────────────────────────────
import 'features/accounts/data/datasources/accounts_remote_data_source.dart';
import 'features/accounts/data/repositories/accounts_repository_impl.dart';
import 'features/accounts/domain/repositories/accounts_repository.dart';
import 'features/accounts/domain/usecases/login.dart';
import 'features/accounts/domain/usecases/logout.dart';
import 'features/accounts/domain/usecases/register.dart';
import 'features/accounts/domain/usecases/get_user_info.dart';
import 'features/accounts/domain/usecases/update_profile.dart';
import 'features/accounts/domain/usecases/change_password.dart';
import 'features/accounts/presentation/blocs/accounts_bloc.dart';

// ─── Settings ─────────────────────────────────────────────────────────
import 'features/settings/presentation/blocs/settings_bloc.dart';

// ─── Educational Opportunities ───────────────────────────────────────
import 'features/educational_opportunities/data/datasources/educational_opportunities_remote_data_source.dart';
import 'features/educational_opportunities/data/repositories/educational_opportunities_repository_impl.dart';
import 'features/educational_opportunities/domain/repositories/educational_opportunities_repository.dart';
import 'features/educational_opportunities/domain/usecases/get_opportunities.dart';
import 'features/educational_opportunities/domain/usecases/get_opportunity_detail.dart';
import 'features/educational_opportunities/domain/usecases/get_favorite_opportunities.dart';
import 'features/educational_opportunities/domain/usecases/add_favorite_opportunity.dart';
import 'features/educational_opportunities/domain/usecases/remove_favorite_opportunity.dart';
import 'features/educational_opportunities/presentation/blocs/educational_opportunities_bloc.dart';

// ─── Legal Resources ─────────────────────────────────────────────────
import 'features/legal_resources/data/datasources/legal_resources_remote_data_source.dart';
import 'features/legal_resources/data/repositories/legal_resources_repository_impl.dart';
import 'features/legal_resources/domain/repositories/legal_resources_repository.dart';
import 'features/legal_resources/domain/usecases/get_resources.dart';
import 'features/legal_resources/domain/usecases/get_resource_detail.dart';
import 'features/legal_resources/domain/usecases/get_favorite_resources.dart';
import 'features/legal_resources/domain/usecases/add_favorite_resource.dart';
import 'features/legal_resources/domain/usecases/remove_favorite_resource.dart';
import 'features/legal_resources/presentation/blocs/legal_resources_bloc.dart';

// ─── Notifications ─────────────────────────────────────────────────
import 'features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'features/notifications/data/repositories/notifications_repository_impl.dart';
import 'features/notifications/domain/repositories/notifications_repository.dart';
import 'features/notifications/domain/usecases/get_notifications.dart';
import 'features/notifications/domain/usecases/get_notification_detail.dart';
import 'features/notifications/presentation/blocs/notifications_bloc.dart';

// ──────────────────────────────────────────────────────────────────────
final sl = GetIt.instance;

// =====================================================================
//  INIT
// =====================================================================
Future<void> init() async {
  // ── Core ───────────────────────────────────────────────────────────
  sl
    ..registerLazySingleton<PreferencesHelper>(() => PreferencesHelper())
    ..registerLazySingleton<http.Client>(() => http.Client())
    ..registerLazySingleton<ApiClient>(() => ApiClient(
          httpClient: sl<http.Client>(),
          preferencesHelper: sl<PreferencesHelper>(),
        ))
    ..registerLazySingleton<ThemeManager>(() => ThemeManager());

  // ── Accounts ───────────────────────────────────────────────────────
  sl
    ..registerLazySingleton<IAccountsRemoteDataSource>(
        () => AccountsRemoteDataSourceImpl(apiClient: sl<ApiClient>()))
    ..registerLazySingleton<AccountsRepository>(() => AccountsRepositoryImpl(
          remoteDataSource: sl<IAccountsRemoteDataSource>(),
          preferencesHelper: sl<PreferencesHelper>(),
        ))
    ..registerFactory(() => Login(sl<AccountsRepository>()))
    ..registerFactory(() => Logout(sl<AccountsRepository>()))
    ..registerFactory(() => Register(sl<AccountsRepository>()))
    ..registerFactory(() => GetUserInfo(sl<AccountsRepository>()))
    ..registerFactory(() => UpdateProfile(sl<AccountsRepository>()))
    ..registerFactory(() => ChangePassword(sl<AccountsRepository>()));

  // ── Settings ───────────────────────────────────────────────────────
  sl.registerFactory<SettingsBloc>(() => SettingsBloc(
        preferencesHelper: sl<PreferencesHelper>(),
        themeManager: sl<ThemeManager>(),
      ));

  // ── Educational Opportunities ─────────────────────────────────────
  sl
    ..registerLazySingleton<IEducationalOpportunitiesRemoteDataSource>(
        () => EducationalOpportunitiesRemoteDataSourceImpl(
              apiClient: sl<ApiClient>(),
            ))
    ..registerLazySingleton<EducationalOpportunitiesRepository>(
        () => EducationalOpportunitiesRepositoryImpl(
              remoteDataSource:
                  sl<IEducationalOpportunitiesRemoteDataSource>(),
            ))
    ..registerFactory(() => GetOpportunities(sl<EducationalOpportunitiesRepository>()))
    ..registerFactory(() => GetOpportunityDetail(sl<EducationalOpportunitiesRepository>()))
    ..registerFactory(() => GetFavoriteOpportunities(sl<EducationalOpportunitiesRepository>()))
    ..registerFactory(() => AddFavoriteOpportunity(sl<EducationalOpportunitiesRepository>()))
    ..registerFactory(() => RemoveFavoriteOpportunity(sl<EducationalOpportunitiesRepository>()));

  // ── Legal Resources ────────────────────────────────────────────────
  sl
    ..registerLazySingleton<ILegalResourcesRemoteDataSource>(
        () => LegalResourcesRemoteDataSourceImpl(apiClient: sl<ApiClient>()))
    ..registerLazySingleton<LegalResourcesRepository>(
        () => LegalResourcesRepositoryImpl(
              remote: sl<ILegalResourcesRemoteDataSource>(),
            ))
    ..registerFactory(() => GetResources(sl<LegalResourcesRepository>()))
    ..registerFactory(() => GetResourceDetail(sl<LegalResourcesRepository>()))
    ..registerFactory(() => GetFavoriteResources(sl<LegalResourcesRepository>()))
    ..registerFactory(() => AddFavoriteResource(sl<LegalResourcesRepository>()))
    ..registerFactory(() => RemoveFavoriteResource(sl<LegalResourcesRepository>()));

  // ── Notifications ─────────────────────────────────────────────────
  sl
    ..registerLazySingleton<INotificationsRemoteDataSource>(
        () => NotificationsRemoteDataSourceImpl(apiClient: sl<ApiClient>()))
    ..registerLazySingleton<NotificationsRepository>(
        () => NotificationsRepositoryImpl(
              remote: sl<INotificationsRemoteDataSource>(),
            ))
    ..registerFactory(() => GetNotifications(sl<NotificationsRepository>()))
    ..registerFactory(() => GetNotificationDetail(sl<NotificationsRepository>()));
}

// =====================================================================
//  Global Bloc providers
// =====================================================================
List<BlocProvider> getGlobalBlocProviders() {
  return [
    BlocProvider<AccountsBloc>(
      create: (_) => AccountsBloc(
        loginUseCase: sl<Login>(),
        logoutUseCase: sl<Logout>(),
        registerUseCase: sl<Register>(),
        getUserInfoUseCase: sl<GetUserInfo>(),
        updateProfileUseCase: sl<UpdateProfile>(),
        changePasswordUseCase: sl<ChangePassword>(),
      ),
    ),
    BlocProvider<SettingsBloc>(create: (_) => sl<SettingsBloc>()),
    BlocProvider<EducationalOpportunitiesBloc>(
      create: (_) => EducationalOpportunitiesBloc(
        repo: sl<EducationalOpportunitiesRepository>(),
      ),
    ),
    BlocProvider<LegalResourcesBloc>(
      create: (_) => LegalResourcesBloc(
        repo: sl<LegalResourcesRepository>(),
      ),
    ),
    BlocProvider<NotificationsBloc>(
      create: (_) => NotificationsBloc(
        getList: sl<GetNotifications>(),
      ),
    ),
  ];
}
