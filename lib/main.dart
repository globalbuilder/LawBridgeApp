import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'injection.dart' as di;
import 'core/theme/theme_manager.dart';
import 'app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Create the BLoC providers from getGlobalBlocProviders()
      providers: di.getGlobalBlocProviders(),
      child: ChangeNotifierProvider<ThemeManager>.value(
        // Provide the ThemeManager from the service locator
        value: di.sl<ThemeManager>(),
        child: Consumer<ThemeManager>(
          builder: (context, themeManager, _) {
            return MaterialApp(
              title: 'LawBridge',
              debugShowCheckedModeBanner: false,
              theme: themeManager.currentTheme,
              initialRoute: AppRouter.splash,
              onGenerateRoute: AppRouter.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
