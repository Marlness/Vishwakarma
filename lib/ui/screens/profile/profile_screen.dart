import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vishwakarmas/core/constants/app_constants.dart';
import 'package:vishwakarmas/core/providers/app_provider.dart';
import 'package:vishwakarmas/core/providers/auth_provider.dart';
import 'package:vishwakarmas/core/providers/language_provider.dart';
import 'package:vishwakarmas/core/services/navigation_service.dart';
import 'package:vishwakarmas/core/utils/app_theme.dart';
import 'package:vishwakarmas/localization/app_localizations.dart';
import 'package:vishwakarmas/routes.dart';
import 'package:vishwakarmas/ui/widgets/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)?.translate ?? (String key) => key;
    final authProvider = Provider.of<AuthProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    final user = authProvider.currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('profile')),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Image and Name
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  // Profile Image
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.primaryColor,
                        width: 2,
                      ),
                      image: user?.profilePicUrl != null
                          ? DecorationImage(
                              image: NetworkImage(user!.profilePicUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: user?.profilePicUrl == null
                        ? const Icon(
                            Icons.person,
                            size: 50,
                            color: AppTheme.primaryColor,
                          )
                        : null,
                  ),
                  const SizedBox(height: 16),
                  // Name
                  Text(
                    user?.name ?? 'User',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Phone Number
                  Text(
                    user?.phoneNumber ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Edit Profile Button
                  OutlinedButton.icon(
                    onPressed: () {
                      NavigationService.navigateTo(
                        AppRoutes.personalDetails,
                        arguments: {'isEditing': true},
                      );
                    },
                    icon: const Icon(Icons.edit, size: 16),
                    label: Text(translate('edit_profile')),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primaryColor,
                      side: const BorderSide(color: AppTheme.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            
            // Profile Menu Items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personal Information Section
                  Text(
                    translate('personal_information'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProfileMenuItem(
                    icon: Icons.person,
                    title: translate('personal_details'),
                    onTap: () {
                      NavigationService.navigateTo(AppRoutes.personalDetails);
                    },
                  ),
                  if (appProvider.userType == AppConstants.userTypeCommunityMember)
                    ProfileMenuItem(
                      icon: Icons.build,
                      title: translate('professional_skills'),
                      onTap: () {
                        // Navigate to professional skills screen
                      },
                    ),
                  if (appProvider.userType == AppConstants.userTypeCommunityMember)
                    ProfileMenuItem(
                      icon: Icons.shopping_bag,
                      title: translate('my_products'),
                      onTap: () {
                        // Navigate to my products screen
                      },
                    ),
                  if (appProvider.userType == AppConstants.userTypeCommunityMember)
                    ProfileMenuItem(
                      icon: Icons.home_repair_service,
                      title: translate('my_services'),
                      onTap: () {
                        // Navigate to my services screen
                      },
                    ),
                  
                  const SizedBox(height: 24),
                  
                  // App Settings Section
                  Text(
                    translate('app_settings'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProfileMenuItem(
                    icon: Icons.language,
                    title: translate('language'),
                    subtitle: languageProvider.isEnglish() ? 'English' : 'ಕನ್ನಡ',
                    onTap: () {
                      _showLanguageDialog(context, languageProvider);
                    },
                  ),
                  ProfileMenuItem(
                    icon: appProvider.isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    title: translate('dark_mode'),
                    trailing: Switch(
                      value: appProvider.isDarkMode,
                      onChanged: (value) {
                        appProvider.setDarkMode(value);
                      },
                      activeColor: AppTheme.primaryColor,
                    ),
                    onTap: () {
                      appProvider.toggleDarkMode();
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // About Section
                  Text(
                    translate('about'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProfileMenuItem(
                    icon: Icons.info,
                    title: translate('about_app'),
                    onTap: () {
                      // Show about app dialog
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.contact_support,
                    title: translate('contact_us'),
                    onTap: () {
                      // Navigate to contact us screen
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.privacy_tip,
                    title: translate('privacy_policy'),
                    onTap: () {
                      // Navigate to privacy policy screen
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.description,
                    title: translate('terms_conditions'),
                    onTap: () {
                      // Navigate to terms and conditions screen
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Logout Button
                  ProfileMenuItem(
                    icon: Icons.exit_to_app,
                    title: translate('logout'),
                    isDestructive: true,
                    onTap: () async {
                      final confirmed = await _showLogoutConfirmationDialog(context);
                      if (confirmed) {
                        await authProvider.logout();
                        NavigationService.navigateToAndRemoveUntil(AppRoutes.languageSelection);
                      }
                    },
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _showLanguageDialog(BuildContext context, LanguageProvider languageProvider) async {
    final translate = AppLocalizations.of(context)?.translate ?? (String key) => key;
    
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translate('select_language')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                leading: Radio<String>(
                  value: 'en',
                  groupValue: languageProvider.locale.languageCode,
                  onChanged: (value) {
                    if (value != null) {
                      languageProvider.setLanguage(value);
                      Navigator.pop(context);
                    }
                  },
                ),
                onTap: () {
                  languageProvider.setLanguage('en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('ಕನ್ನಡ'),
                leading: Radio<String>(
                  value: 'kn',
                  groupValue: languageProvider.locale.languageCode,
                  onChanged: (value) {
                    if (value != null) {
                      languageProvider.setLanguage(value);
                      Navigator.pop(context);
                    }
                  },
                ),
                onTap: () {
                  languageProvider.setLanguage('kn');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  
  Future<bool> _showLogoutConfirmationDialog(BuildContext context) async {
    final translate = AppLocalizations.of(context)?.translate ?? (String key) => key;
    
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translate('logout')),
          content: Text(translate('logout_confirmation')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(translate('cancel')),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(translate('logout')),
            ),
          ],
        );
      },
    ) ?? false;
  }
}
