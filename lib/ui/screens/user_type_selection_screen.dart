import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vishwakarmas/core/constants/app_constants.dart';
import 'package:vishwakarmas/core/providers/app_provider.dart';
import 'package:vishwakarmas/core/services/navigation_service.dart';
import 'package:vishwakarmas/core/utils/app_theme.dart';
import 'package:vishwakarmas/localization/app_localizations.dart';
import 'package:vishwakarmas/routes.dart';
import 'package:vishwakarmas/ui/widgets/user_type_card.dart';

class UserTypeSelectionScreen extends StatelessWidget {
  const UserTypeSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final translate = AppLocalizations.of(context)?.translate ?? (String key) => key;
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              // Title
              Text(
                translate('select_user_type'),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                translate('app_tagline'),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Admin Option
                      UserTypeCard(
                        title: translate('admin'),
                        subtitle: 'Udupi Dist Sri Vishwakarma Educational Trust',
                        iconData: Icons.admin_panel_settings,
                        isSelected: appProvider.userType == AppConstants.userTypeAdmin,
                        onTap: () {
                          appProvider.setUserType(AppConstants.userTypeAdmin);
                        },
                      ),
                      const SizedBox(height: 16),
                      // Community Member Option
                      UserTypeCard(
                        title: translate('community_member'),
                        subtitle: translate('data_entry'),
                        iconData: Icons.people,
                        isSelected: appProvider.userType == AppConstants.userTypeCommunityMember,
                        onTap: () {
                          appProvider.setUserType(AppConstants.userTypeCommunityMember);
                        },
                      ),
                      const SizedBox(height: 16),
                      // General Public Option
                      UserTypeCard(
                        title: translate('general_public'),
                        subtitle: translate('access_services'),
                        iconData: Icons.public,
                        isSelected: appProvider.userType == AppConstants.userTypeGeneralPublic,
                        onTap: () {
                          appProvider.setUserType(AppConstants.userTypeGeneralPublic);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Continue Button
              ElevatedButton(
                onPressed: () => _navigateToNextScreen(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  translate('continue'),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    
    // Navigate to login screen
    NavigationService.navigateToAndReplace(AppRoutes.login);
  }
}
