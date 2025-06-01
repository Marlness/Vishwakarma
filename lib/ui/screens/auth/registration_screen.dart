import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vishwakarmas/core/constants/app_constants.dart';
import 'package:vishwakarmas/core/models/user_model.dart';
import 'package:vishwakarmas/core/providers/app_provider.dart';
import 'package:vishwakarmas/core/providers/auth_provider.dart';
import 'package:vishwakarmas/core/services/data_validation_service.dart';
import 'package:vishwakarmas/core/services/navigation_service.dart';
import 'package:vishwakarmas/core/utils/app_theme.dart';
import 'package:vishwakarmas/core/utils/validators.dart';
import 'package:vishwakarmas/localization/app_localizations.dart';
import 'package:vishwakarmas/routes.dart';
import 'package:vishwakarmas/ui/widgets/custom_button.dart';
import 'package:vishwakarmas/ui/widgets/custom_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late int _userType;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get the user type from the app provider
      _userType = Provider.of<AppProvider>(context, listen: false).userType;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)?.translate ?? (String key) => key;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('register')),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User Type Info
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _getUserTypeIcon(),
                                color: AppTheme.primaryColor,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _getUserTypeText(translate),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  NavigationService.navigateToAndReplace(AppRoutes.userTypeSelection);
                                },
                                child: Text(
                                  translate('change'),
                                  style: const TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Name Field
                        CustomTextField(
                          controller: _nameController,
                          label: translate('name'),
                          hint: translate('enter_name'),
                          prefixIcon: Icons.person,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return translate('required_field');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Phone Number Field
                        CustomTextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          label: translate('phone_number'),
                          hint: translate('enter_phone_number'),
                          prefixIcon: Icons.phone_android,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return translate('required_field');
                            }
                            // Simple validation for Indian phone numbers
                            if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return translate('invalid_phone');
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Human Verification (Captcha)
                        _buildHumanVerification(),
                        
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
              // Register Button
              CustomButton(
                onPressed: _isLoading ? null : _register,
                text: translate('send_otp'),
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    translate('already_have_account'),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      NavigationService.navigateToAndReplace(AppRoutes.login);
                    },
                    child: Text(
                      translate('login'),
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHumanVerification() {
    // Simple human verification/captcha placeholder
    // In a real app, this would be implemented with a proper CAPTCHA service
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Human Verification',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (value) {},
                activeColor: AppTheme.primaryColor,
              ),
              const Text('I am a human'),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getUserTypeIcon() {
    switch (_userType) {
      case AppConstants.userTypeAdmin:
        return Icons.admin_panel_settings;
      case AppConstants.userTypeCommunityMember:
        return Icons.people;
      case AppConstants.userTypeGeneralPublic:
        return Icons.public;
      default:
        return Icons.person;
    }
  }

  String _getUserTypeText(Function translate) {
    switch (_userType) {
      case AppConstants.userTypeAdmin:
        return translate('admin');
      case AppConstants.userTypeCommunityMember:
        return translate('community_member');
      case AppConstants.userTypeGeneralPublic:
        return translate('general_public');
      default:
        return '';
    }
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      final translate = AppLocalizations.of(context)?.translate ?? (String key) => key;
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      // Check for duplicate entries first
      final validationService = DataValidationService();
      
      // First check if the phone number is already registered
      final bool isPhoneRegistered = await validationService.isPhoneNumberRegistered(_phoneController.text);
      
      if (isPhoneRegistered) {
        setState(() {
          _isLoading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(translate('phone_already_registered')),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      // For community members, perform more thorough duplicate detection
      if (_userType == AppConstants.userTypeCommunityMember) {
        // Create a partial user model with available data
        final partialUser = UserModel(
          name: _nameController.text,
          phoneNumber: _phoneController.text,
          userType: _userType,
          createdAt: DateTime.now(), // Adding required field
          updatedAt: DateTime.now(), // Adding required field
          // Removed isActive as it's not in the model
        );
        
        // Find potential duplicates
        final potentialDuplicates = await validationService.findPotentialDuplicates(partialUser);
        
        if (potentialDuplicates.isNotEmpty) {
          setState(() {
            _isLoading = false;
          });
          
          // Show dialog with potential duplicates
          bool shouldProceed = await _showDuplicateWarningDialog(potentialDuplicates);
          
          if (!shouldProceed) {
            return; // User chose not to proceed
          }
        }
      }
      
      // Proceed with registration if no duplicates found or user confirmed to proceed
      final success = await authProvider.sendOTP(_phoneController.text);

      setState(() {
        _isLoading = false;
      });

      if (success) {
        NavigationService.navigateTo(
          AppRoutes.otpVerification,
          arguments: {
            'phoneNumber': _phoneController.text,
            'isRegistration': true,
            'name': _nameController.text,
            'userType': _userType,
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.error ?? translate('failed_to_send_otp')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  
  // Show a dialog warning the user about potential duplicate entries
  Future<bool> _showDuplicateWarningDialog(List<Map<String, dynamic>> potentialDuplicates) async {
    final translate = AppLocalizations.of(context)?.translate ?? (String key) => key;
    
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translate('duplicate_warning')),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(translate('similar_entries_found')),
                const SizedBox(height: 16),
                ...potentialDuplicates.map((duplicate) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${duplicate['user']['name']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${duplicate['user']['phoneNumber']}'),
                      if (duplicate['user']['address'] != null)
                        Text('${duplicate['user']['address']}'),
                      Text(
                        '${translate('match_confidence')}: ${(duplicate['confidence'] * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: duplicate['confidence'] > 0.8 ? Colors.red : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
                const SizedBox(height: 16),
                Text(
                  translate('duplicate_warning_message'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(translate('cancel')),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(translate('proceed_anyway')),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ) ?? false;
  }
}
