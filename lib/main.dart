import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vishwakarmas/core/constants/app_constants.dart';
import 'package:vishwakarmas/core/providers/app_provider.dart';
import 'package:vishwakarmas/core/providers/auth_provider.dart';
import 'package:vishwakarmas/core/providers/language_provider.dart';
import 'package:vishwakarmas/core/services/navigation_service.dart';
import 'package:vishwakarmas/core/utils/app_theme.dart';
import 'package:vishwakarmas/localization/app_localizations.dart';
import 'package:vishwakarmas/routes.dart';
import 'package:vishwakarmas/ui/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Initialize shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  
  // Initialize Firebase when ready
  // Commented out for now as we don't have Firebase setup yet
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (_) => AppProvider(sharedPreferences),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(sharedPreferences),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(sharedPreferences),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: appProvider.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      locale: languageProvider.locale,
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('kn', 'IN'), // Kannada
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...AppLocalizations.localizationsDelegates,
      ],
      home: const SplashScreen(),
    );
  }
}
