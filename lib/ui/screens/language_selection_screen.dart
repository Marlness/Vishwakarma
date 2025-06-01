import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vishwakarmas/core/providers/language_provider.dart';
import 'package:vishwakarmas/core/services/navigation_service.dart';
import 'package:vishwakarmas/core/utils/app_theme.dart';
import 'package:vishwakarmas/localization/app_localizations.dart';
import 'package:vishwakarmas/routes.dart';
import 'package:vishwakarmas/ui/widgets/language_tile.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              // App Logo
              Container(
                width: 120,
                height: 120,
                child: Image.asset(
                  'assets/images/vishwakarma_logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback if image is not found
                    return const Icon(
                      Icons.build_circle_outlined,
                      size: 80,
                      color: AppTheme.primaryColor,
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              // Title
              Text(
                'Choose your language',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Subtitle in Kannada
              const Text(
                'ನಿಮ್ಮ ಭಾಷೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              // English Language Option
              LanguageTile(
                title: 'English',
                isSelected: languageProvider.locale.languageCode == 'en',
                onTap: () => _selectLanguage(context, 'en'),
              ),
              const SizedBox(height: 16),
              // Kannada Language Option
              LanguageTile(
                title: 'ಕನ್ನಡ',
                isSelected: languageProvider.locale.languageCode == 'kn',
                onTap: () => _selectLanguage(context, 'kn'),
              ),
              const Spacer(),
              // Continue Button
              ElevatedButton(
                onPressed: () => _navigateToNextScreen(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectLanguage(BuildContext context, String languageCode) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    languageProvider.setLanguage(languageCode);
  }

  void _navigateToNextScreen() {
    NavigationService.navigateToAndReplace(AppRoutes.userTypeSelection);
  }
}
