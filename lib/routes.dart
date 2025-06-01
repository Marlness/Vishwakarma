import 'package:flutter/material.dart';
import 'package:vishwakarmas/ui/screens/auth/login_screen.dart';
import 'package:vishwakarmas/ui/screens/auth/otp_verification_screen.dart';
import 'package:vishwakarmas/ui/screens/auth/registration_screen.dart';
import 'package:vishwakarmas/ui/screens/home_screen.dart';
import 'package:vishwakarmas/ui/screens/language_selection_screen.dart';
import 'package:vishwakarmas/ui/screens/marketplace/marketplace_screen.dart';
import 'package:vishwakarmas/ui/screens/marketplace/product_detail_screen.dart';
import 'package:vishwakarmas/ui/screens/profile/personal_details_screen.dart';
import 'package:vishwakarmas/ui/screens/profile/profile_screen.dart';
import 'package:vishwakarmas/ui/screens/services/service_detail_screen.dart';
import 'package:vishwakarmas/ui/screens/services/services_screen.dart';
import 'package:vishwakarmas/ui/screens/splash_screen.dart';
import 'package:vishwakarmas/ui/screens/user_type_selection_screen.dart';

class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String languageSelection = '/language-selection';
  static const String userTypeSelection = '/user-type-selection';
  static const String login = '/login';
  static const String register = '/register';
  static const String otpVerification = '/otp-verification';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String personalDetails = '/personal-details';
  static const String marketplace = '/marketplace';
  static const String productDetail = '/product-detail';
  static const String services = '/services';
  static const String serviceDetail = '/service-detail';

  // Route generator
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case languageSelection:
        return MaterialPageRoute(builder: (_) => const LanguageSelectionScreen());
      case userTypeSelection:
        return MaterialPageRoute(builder: (_) => const UserTypeSelectionScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case otpVerification:
        final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            phoneNumber: args['phoneNumber'],
            isRegistration: args['isRegistration'] ?? false,
            name: args['name'],
            userType: args['userType'],
          ),
        );
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case personalDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => PersonalDetailsScreen(
            isEditing: args?['isEditing'] ?? false,
          ),
        );
      case marketplace:
        return MaterialPageRoute(builder: (_) => const MarketplaceScreen());
      case productDetail:
        final String productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(productId: productId),
        );
      case services:
        return MaterialPageRoute(builder: (_) => const ServicesScreen());
      case serviceDetail:
        final String serviceId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ServiceDetailScreen(serviceId: serviceId),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
