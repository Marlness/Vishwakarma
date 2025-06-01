import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vishwakarmas/core/providers/auth_provider.dart';
import 'package:vishwakarmas/core/services/navigation_service.dart';
import 'package:vishwakarmas/core/utils/app_theme.dart';
import 'package:vishwakarmas/localization/app_localizations.dart';
import 'package:vishwakarmas/routes.dart';
import 'package:vishwakarmas/ui/widgets/custom_button.dart';
import 'package:vishwakarmas/ui/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)?.translate ?? (String key) => key;
    final authProvider = Provider.of<AuthProvider>(context);
    
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
                translate('login'),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                translate('enter_phone_number'),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Phone Number Field
                        CustomTextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          label: translate('phone_number'),
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
                        // Send OTP Button
                        CustomButton(
                          onPressed: _isLoading ? null : _sendOTP,
                          text: translate('send_otp'),
                          isLoading: _isLoading,
                        ),
                        const SizedBox(height: 24),
                        // Register Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {
                                NavigationService.navigateTo(AppRoutes.register);
                              },
                              child: Text(
                                translate('register'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.sendOTP(_phoneController.text);

      setState(() {
        _isLoading = false;
      });

      if (success) {
        NavigationService.navigateTo(
          AppRoutes.otpVerification,
          arguments: {
            'phoneNumber': _phoneController.text,
            'isRegistration': false,
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.error ?? 'Failed to send OTP'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
