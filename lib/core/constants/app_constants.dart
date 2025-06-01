class AppConstants {
  static const String appName = "Vishwakarmas";
  static const String appTagline = "Tell us what you want - We will create it for you";
  
  // User types
  static const int userTypeAdmin = 1; // Admin (Udupi Dist Sri Vishwakarma Educational Trust)
  static const int userTypeCommunityMember = 2; // Vishwakarma People (Data Entry)
  static const int userTypeGeneralPublic = 3; // General Public
  
  // Professions
  static const List<String> traditionalProfessions = [
    'Goldsmiths', 
    'Carpenters', 
    'Sculptors', 
    'Blacksmiths', 
    'BronzeSmiths'
  ];
  
  // Education levels
  static const Map<String, String> educationLevels = {
    'kindergarten': 'ಶಿಶುವಿಹಾರ/ Kinder garden',
    'primary': 'ಪ್ರಾಥಮಿಕ ಶಾಲೆ(1ನೇ ತರಗತಿ - 7ನೇ ತರಗತಿ)/ Primary School (1st Standard- 7th Standard)',
    'highSchool': 'ಪ್ರೌಢಶಾಲೆ (8ನೇ ತರಗತಿ - 10 ನೇ ತರಗತಿ)/ High School (8th Standard- 10th Standard)',
    'puc': 'ಪದವಿ ಪೂರ್ವ ಶಿಕ್ಷಣ (1ನೇ ಪಿಯುಸಿ-2ನೇ ಪಿಯುಸಿ)/ PUC (1st PUC-2nd PUC)',
    'diploma': 'ಡಿಪ್ಲೊಮಾ ಶಿಕ್ಷಣ/ Diploma Education',
    'graduation': 'ಪದವಿ ಶಿಕ್ಷಣ/ Graduation (BA/B.Com/B.Sc/BBA)',
    'postGraduation': 'ಉನ್ನತ ಶಿಕ್ಷಣ/ Higher Education (MA/M.Com/M.Sc/MBA)',
    'professional': 'ವೃತ್ತಿಪರ ಕೋರ್ಸ್/ Professional Course (B. E/B. Tech/M. Tech)',
    'medical': 'ವೈದ್ಯಕೀಯ ಕೋರ್ಸ್ / Medical Course (MBBS)'
  };
  
  // Gender types
  static const Map<String, String> genderTypes = {
    'male': 'ಪುರುಷ - MALE',
    'female': 'ಮಹಿಳೆ - FEMALE',
    'other': 'ಇತರ - OTHER'
  };
  
  // Family relationships
  static const Map<String, String> familyRelations = {
    'head': 'ನಾನು ಕುಟುಂಬದ ಯಜಮಾನ/ I am Head of the Family',
    'mother': 'ತಾಯಿ / Mother',
    'wife': 'ಹೆಂಡತಿ / Wife',
    'son': 'ಮಗ / Son',
    'daughterInLaw': 'ಸೊಸೆ / Daughter in Law',
    'daughter': 'ಮಗಳು / Daughter',
    'youngerBrother': 'ತಮ್ಮ / Younger Brother',
    'sisterInLaw': 'ನಾದಿನಿ/ Sister in Law',
    'sister': 'ಸಹೋದರಿ / Sister',
    'grandson': 'ಮೊಮ್ಮಗ / Grandson',
    'granddaughter': 'ಮೊಮ್ಮಗಳು / Granddaughter'
  };
  
  // Gothra types
  static const Map<String, String> gothraTypes = {
    'saanaga': 'ಸಾನಗ -SAANAGA',
    'sanaatana': 'ಸನಾತನ - SANAATANA',
    'ahabhunasa': 'ಅಹಭೂನಸ - AHABHUNASA',
    'pratnasa': 'ಪ್ರತ್ನಸ - PRATNASA',
    'suparnasa': 'ಸುಪರ್ಣಸ - SUPARNASA'
  };
  
  // Employment types
  static const Map<String, String> employmentTypes = {
    'student': 'ವಿದ್ಯಾರ್ಥಿ - STUDENT',
    'private': 'ಖಾಸಗಿ - PRIVATE',
    'selfEmployed': 'ಸ್ವ ಉದ್ಯೋಗ - SELF EMPLOYED',
    'government': 'ಸರಕಾರಿ - GOVERNMENT',
    'housewife': 'ಗೃಹಿಣಿ - HOUSE WIFE',
    'retired': 'ನಿವೃತ್ತಿ ಜೀವನ - RETIRED'
  };
  
  // Income ranges
  static const Map<String, String> incomeRanges = {
    'belowOneLakh': 'ಒಂದು ಲಕ್ಷಕ್ಕಿಂತ ಕಡಿಮೆ - Below One lakh',
    'aboveOneLakh': 'ಒಂದು ಲಕ್ಷಕ್ಕಿಂತ ಹೆಚ್ಚು - Above One lakh',
    'twoToFiveLakh': 'ಎರಡು ಲಕ್ಷದಿಂದ ಐದು ಲಕ್ಷ - Two lakhs to Five lakhs',
    'aboveFiveLakh': 'ಐದು ಲಕ್ಷಕ್ಕಿಂತ ಹೆಚ್ಚು - Above Five lakhs',
    'noIncome': 'ಆದಾಯ ಇಲ್ಲ/ No income'
  };
  
  // Ration card types
  static const Map<String, String> rationCardTypes = {
    'apl': 'APL -ಎಪಿಎಲ್',
    'bpl': 'BPL - ಬಿಪಿಎಲ್',
    'none': 'ರೇಷನ್ ಕಾರ್ಡ್ ಇಲ್ಲ/ No Ration Card'
  };
  
  // Yes/No response in both languages
  static const Map<String, Map<String, String>> yesNoResponse = {
    'yes': {'en': 'Yes', 'kn': 'ಹೌದು'},
    'no': {'en': 'No', 'kn': 'ಅಲ್ಲ'},
    'na': {'en': 'Not Applicable', 'kn': 'ಅನ್ವಯಿಸುವುದಿಲ್ಲ'}
  };
  
  // House ownership types
  static const Map<String, String> houseOwnershipTypes = {
    'own': 'ಸ್ವಂತ / Own',
    'rented': 'ಬಾಡಿಗೆ / Rented'
  };
  
  // API endpoints (to be implemented)
  static const String baseUrl = 'https://api.vishwakarmas.org/api';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String verifyOtpEndpoint = '/auth/verify-otp';
  static const String userProfileEndpoint = '/user/profile';
  static const String communityServicesEndpoint = '/services';
  static const String marketplaceEndpoint = '/marketplace';
  
  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userTypeKey = 'user_type';
  static const String userNameKey = 'user_name';
  static const String darkModeKey = 'dark_mode';
  static const String languageCodeKey = 'language_code';
}
