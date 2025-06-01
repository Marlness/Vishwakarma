import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vishwakarmas/core/models/user_model.dart';

class DataValidationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  /// Checks if a user with the given phone number already exists
  Future<bool> isPhoneNumberRegistered(String phoneNumber) async {
    try {
      // For now simulate a check since we don't have Firebase initialized
      // In a real app, this would query Firestore
      
      // Example implementation with Firestore:
      // final QuerySnapshot result = await _firestore
      //     .collection('users')
      //     .where('phoneNumber', isEqualTo: phoneNumber)
      //     .limit(1)
      //     .get();
      
      // return result.docs.isNotEmpty;
      
      // Mock implementation for development
      await Future.delayed(const Duration(seconds: 1));
      return false; // Replace with actual implementation
    } catch (e) {
      print('Error checking phone number: $e');
      return false;
    }
  }
  
  /// Checks if a user with the given Aadhar number already exists
  Future<bool> isAadharNumberRegistered(String aadharNumber) async {
    if (aadharNumber.isEmpty) return false;
    
    try {
      // Example implementation with Firestore:
      // final QuerySnapshot result = await _firestore
      //     .collection('users')
      //     .where('aadharNo', isEqualTo: aadharNumber)
      //     .limit(1)
      //     .get();
      
      // return result.docs.isNotEmpty;
      
      // Mock implementation for development
      await Future.delayed(const Duration(seconds: 1));
      return false; // Replace with actual implementation
    } catch (e) {
      print('Error checking Aadhar number: $e');
      return false;
    }
  }
  
  /// Checks for potential duplicate entries based on multiple fields
  Future<Map<String, String>> checkForDuplicates(UserModel user) async {
    Map<String, String> duplicateFields = {};
    
    // Check phone number
    if (await isPhoneNumberRegistered(user.phoneNumber)) {
      duplicateFields['phoneNumber'] = 'Phone number is already registered';
    }
    
    // Check Aadhar number if provided
    if (user.aadharNo != null && user.aadharNo!.isNotEmpty) {
      if (await isAadharNumberRegistered(user.aadharNo!)) {
        duplicateFields['aadharNo'] = 'Aadhar number is already registered';
      }
    }
    
    // Additional duplicate checks could include:
    // - Name + Father's name + Date of birth combination
    // - Name + Address + Family details
    
    // In a real implementation, you would query Firestore to look for potential matches
    // based on combinations of these fields
    
    return duplicateFields;
  }
  
  /// Checks if a new user entry might be a duplicate based on fuzzy matching
  /// Returns a list of potential matches with their match confidence
  Future<List<Map<String, dynamic>>> findPotentialDuplicates(UserModel user) async {
    try {
      // For a real implementation, you would:
      // 1. Query for users with similar names (using indexing/search tools)
      // 2. Compare other fields (father's name, village, age) for similarity
      // 3. Calculate a match confidence score
      
      // Example implementation with Firestore + custom logic:
      // final QuerySnapshot nameMatches = await _firestore
      //    .collection('users')
      //    .where('nameSearchTokens', arrayContains: getTokens(user.name))
      //    .limit(10)
      //    .get();
      
      // return nameMatches.docs.map((doc) {
      //   final userData = doc.data() as Map<String, dynamic>;
      //   final confidence = calculateSimilarity(userData, user.toJson());
      //   return {
      //     'user': userData,
      //     'confidence': confidence,
      //     'id': doc.id,
      //   };
      // }).where((match) => match['confidence'] > 0.7).toList();
      
      // Mock implementation for development
      return [];
    } catch (e) {
      print('Error finding potential duplicates: $e');
      return [];
    }
  }
  
  // Helper function to get search tokens from a name
  List<String> getTokens(String text) {
    if (text.isEmpty) return [];
    
    // Convert to lowercase
    text = text.toLowerCase();
    
    // Split by space and create tokens
    List<String> tokens = text.split(' ');
    
    // Add additional tokens for prefix matching
    List<String> prefixTokens = [];
    for (String token in tokens) {
      for (int i = 1; i <= token.length; i++) {
        prefixTokens.add(token.substring(0, i));
      }
    }
    
    return [...tokens, ...prefixTokens];
  }
  
  // Calculate similarity between two user records
  double calculateSimilarity(Map<String, dynamic> user1, Map<String, dynamic> user2) {
    int matchPoints = 0;
    int totalPoints = 0;
    
    // Compare name (high weight)
    if (compareStrings(user1['name'], user2['name'])) {
      matchPoints += 3;
    }
    totalPoints += 3;
    
    // Compare father's name (high weight)
    if (compareStrings(user1['fatherName'], user2['fatherName'])) {
      matchPoints += 3;
    }
    totalPoints += 3;
    
    // Compare date of birth (high weight)
    if (user1['dateOfBirth'] != null && user2['dateOfBirth'] != null &&
        user1['dateOfBirth'] == user2['dateOfBirth']) {
      matchPoints += 3;
    }
    totalPoints += 3;
    
    // Compare temple/village (medium weight)
    if (compareStrings(user1['temple'], user2['temple'])) {
      matchPoints += 2;
    }
    totalPoints += 2;
    
    // Compare gothra (medium weight)
    if (compareStrings(user1['gothra'], user2['gothra'])) {
      matchPoints += 2;
    }
    totalPoints += 2;
    
    // Calculate similarity score (0 to 1)
    return totalPoints > 0 ? matchPoints / totalPoints : 0;
  }
  
  // Helper function to compare strings with null safety
  bool compareStrings(String? str1, String? str2) {
    if (str1 == null || str2 == null) return false;
    if (str1.isEmpty || str2.isEmpty) return false;
    return str1.toLowerCase() == str2.toLowerCase();
  }
}
