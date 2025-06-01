import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  static NavigatorState? get navigator => navigatorKey.currentState;
  
  // Navigate to a named route
  static Future<dynamic>? navigateTo(String routeName, {Object? arguments}) {
    return navigator?.pushNamed(routeName, arguments: arguments);
  }
  
  // Navigate to a named route and remove all previous routes
  static Future<dynamic>? navigateToAndRemoveUntil(String routeName, {Object? arguments}) {
    return navigator?.pushNamedAndRemoveUntil(
      routeName, 
      (Route<dynamic> route) => false,
      arguments: arguments
    );
  }
  
  // Replace current route with a named route
  static Future<dynamic>? navigateToAndReplace(String routeName, {Object? arguments}) {
    return navigator?.pushReplacementNamed(routeName, arguments: arguments);
  }
  
  // Go back to previous route
  static void goBack() {
    return navigator?.pop();
  }
  
  // Go back to previous route with result
  static void goBackWithResult(dynamic result) {
    return navigator?.pop(result);
  }
  
  // Go back until a specific route
  static void goBackUntil(String routeName) {
    return navigator?.popUntil(ModalRoute.withName(routeName));
  }
}
