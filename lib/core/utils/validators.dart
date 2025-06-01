/// Utility class for form validation functions
class Validators {
  /// Validates a phone number (basic Indian format validation)
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  /// Validates a name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }

  /// Validates an email address
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Email can be optional
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates an Aadhar number
  static String? validateAadhar(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Aadhar can be optional
    }
    if (value.length != 12 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid 12-digit Aadhar number';
    }
    return null;
  }

  /// Validates OTP
  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    if (value.length != 6 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid 6-digit OTP';
    }
    return null;
  }
}
