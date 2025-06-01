import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vishwakarmas/core/constants/app_constants.dart';
import 'package:vishwakarmas/core/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  final SharedPreferences _preferences;
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _authToken;
  String? _error;

  AuthProvider(this._preferences) {
    _loadUserFromPrefs();
  }

  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _authToken != null;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Load user from shared preferences
  void _loadUserFromPrefs() {
    final userJson = _preferences.getString('user');
    final token = _preferences.getString(AppConstants.tokenKey);
    
    if (userJson != null) {
      _currentUser = UserModel.fromJson(json.decode(userJson));
    }
    
    if (token != null) {
      _authToken = token;
    }
    
    notifyListeners();
  }

  // Save user to shared preferences
  Future<void> _saveUserToPrefs() async {
    if (_currentUser != null) {
      await _preferences.setString('user', json.encode(_currentUser!.toJson()));
    }
    if (_authToken != null) {
      await _preferences.setString(AppConstants.tokenKey, _authToken!);
    }
  }

  // Send OTP to phone number for login or registration
  Future<bool> sendOTP(String phoneNumber) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      // In a real app, you would make an actual API call here
      // For now, we'll simulate a successful OTP send
      await Future.delayed(const Duration(seconds: 2));
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = "Failed to send OTP. Please try again.";
      notifyListeners();
      return false;
    }
  }

  // Verify OTP for login
  Future<bool> verifyOTP(String phoneNumber, String otp) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      // In a real app, you would validate the OTP with a backend service
      // For now, we'll simulate a successful verification with any 6-digit code
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate getting user data from server
      final userData = {
        'id': '123456',
        'name': 'Test User',
        'phoneNumber': phoneNumber,
        'userType': 2, // Community Member
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };
      
      _currentUser = UserModel.fromJson(userData);
      _authToken = 'dummy_auth_token';
      
      await _saveUserToPrefs();
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = "Failed to verify OTP. Please try again.";
      notifyListeners();
      return false;
    }
  }

  // Register new user
  Future<bool> register({
    required String name,
    required String phoneNumber,
    required String otp,
    required int userType,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      // In a real app, you would register the user with a backend service
      // For now, we'll simulate a successful registration
      await Future.delayed(const Duration(seconds: 2));
      
      // Create a new user
      final userData = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': name,
        'phoneNumber': phoneNumber,
        'userType': userType,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };
      
      _currentUser = UserModel.fromJson(userData);
      _authToken = 'dummy_auth_token';
      
      await _saveUserToPrefs();
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = "Failed to register. Please try again.";
      notifyListeners();
      return false;
    }
  }

  // Update user profile
  Future<bool> updateProfile(UserModel updatedUser) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      // In a real app, you would update the user with a backend service
      // For now, we'll simulate a successful update
      await Future.delayed(const Duration(seconds: 2));
      
      _currentUser = updatedUser.copyWith(
        updatedAt: DateTime.now(),
      );
      
      await _saveUserToPrefs();
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = "Failed to update profile. Please try again.";
      notifyListeners();
      return false;
    }
  }
  
  // Update profile picture
  Future<bool> updateProfilePicture(String imagePath) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      // In a real app, you would upload the image to a storage service
      // and get the URL to store in the user profile
      await Future.delayed(const Duration(seconds: 2));
      
      if (_currentUser != null) {
        _currentUser = _currentUser!.copyWith(
          profilePicUrl: "https://example.com/profile/$imagePath",
          updatedAt: DateTime.now(),
        );
        
        await _saveUserToPrefs();
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = "Failed to update profile picture. Please try again.";
      notifyListeners();
      return false;
    }
  }
  
  // Logout
  Future<void> logout() async {
    _currentUser = null;
    _authToken = null;
    await _preferences.remove('user');
    await _preferences.remove(AppConstants.tokenKey);
    notifyListeners();
  }

  // Check if user is a community member
  bool isCommunityMember() {
    return _currentUser?.userType == AppConstants.userTypeCommunityMember;
  }
  
  // Check if user is an admin
  bool isAdmin() {
    return _currentUser?.userType == AppConstants.userTypeAdmin;
  }
}
