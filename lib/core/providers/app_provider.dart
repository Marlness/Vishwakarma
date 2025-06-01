import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vishwakarmas/core/constants/app_constants.dart';

class AppProvider extends ChangeNotifier {
  final SharedPreferences _preferences;
  bool _isDarkMode = false;
  int _userType = AppConstants.userTypeCommunityMember; // Default user type
  
  AppProvider(this._preferences) {
    _loadSettings();
  }
  
  // Getters
  bool get isDarkMode => _isDarkMode;
  int get userType => _userType;
  
  // Load settings from shared preferences
  void _loadSettings() {
    _isDarkMode = _preferences.getBool(AppConstants.darkModeKey) ?? false;
    _userType = _preferences.getInt(AppConstants.userTypeKey) ?? AppConstants.userTypeCommunityMember;
    notifyListeners();
  }
  
  // Toggle dark mode
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    _preferences.setBool(AppConstants.darkModeKey, _isDarkMode);
    notifyListeners();
  }
  
  // Set dark mode
  void setDarkMode(bool value) {
    _isDarkMode = value;
    _preferences.setBool(AppConstants.darkModeKey, _isDarkMode);
    notifyListeners();
  }
  
  // Set user type (Admin, Community Member, or General Public)
  void setUserType(int type) {
    _userType = type;
    _preferences.setInt(AppConstants.userTypeKey, _userType);
    notifyListeners();
  }
  
  // Check if user is admin
  bool isAdmin() {
    return _userType == AppConstants.userTypeAdmin;
  }
  
  // Check if user is community member
  bool isCommunityMember() {
    return _userType == AppConstants.userTypeCommunityMember;
  }
  
  // Check if user is general public
  bool isGeneralPublic() {
    return _userType == AppConstants.userTypeGeneralPublic;
  }
}
