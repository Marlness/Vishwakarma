# Vishwakarmas - Community App

A cross-platform mobile application for the Vishwakarma community built with Flutter. This app serves three main user types: administrators, community members, and the general public. It facilitates community census collection, showcases traditional skills and crafts, and helps connect skilled artisans with potential customers.

## Features

### User Authentication
- Phone number based OTP authentication
- User type selection (Admin, Community Member, General Public)
- Language selection (English/ಕನ್ನಡ)

### Profile Management
- Comprehensive personal details collection
- Traditional profession and skill management
- Family information
- Socio-economic data collection

### Marketplace
- Browse and search products made by community artisans
- Product listings categorized by traditional professions
- Contact sellers directly
- Detailed product information and images

### Service Directory
- Find skilled professionals from the community
- Service listings categorized by profession
- View detailed provider information
- Contact service providers directly

### Additional Features
- Multi-language support (English and Kannada)
- Dark mode
- Community census data collection
- Promotion of traditional Vishwakarma professions

## Project Structure

```
lib/
├── core/
│   ├── constants/        # App-wide constants
│   ├── models/           # Data models
│   ├── providers/        # State management
│   ├── services/         # Backend services
│   └── utils/            # Utility functions
├── localization/         # Multi-language support
├── ui/
│   ├── screens/          # App screens
│   │   ├── auth/         # Authentication screens
│   │   ├── marketplace/  # Marketplace screens
│   │   ├── profile/      # Profile screens
│   │   └── services/     # Service screens
│   └── widgets/          # Reusable UI components
├── main.dart             # App entry point
└── routes.dart           # App navigation
```

## Traditional Professions

The app focuses on the five traditional professions of the Vishwakarma community:
1. Goldsmiths
2. Carpenters
3. Sculptors
4. Blacksmiths
5. BronzeSmiths

## Getting Started

### Prerequisites
- Flutter SDK
- Android Studio or VS Code
- Firebase account (for authentication and database)

### Installation
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Configure Firebase
4. Run the app with `flutter run`

### Running the App in a Web Browser

#### Prerequisites for Web Development
- Flutter SDK with web support enabled
- A modern web browser (Chrome recommended for development)

#### Steps to Run in Browser
1. **Enable Flutter web support** (if not already enabled):
   ```
   flutter config --enable-web
   ```

2. **Check available devices**:
   ```
   flutter devices
   ```

3. **Run the app in Chrome**:
   ```
   flutter run -d chrome
   ```
   
4. **Or run on a web server** (accessible from any browser):
   ```
   flutter run -d web-server --web-hostname=0.0.0.0 --web-port=8080
   ```
   Then open `http://localhost:8080` in any browser

5. **Build for web deployment**:
   ```
   flutter build web
   ```
   The output will be in the `build/web` directory, which can be deployed to any web hosting service.

#### Troubleshooting Web Setup
- If Flutter is not found, ensure the Flutter SDK is in your system PATH
- For Windows users, add `[PATH_TO_FLUTTER]\bin` to your system PATH
- If web devices are not showing, run `flutter doctor` to check for issues

## Future Enhancements
- Implementation of actual backend services
- Analytics dashboard for community census data
- Online payment integration
- In-app messaging between users
- Enhanced search and filtering options
