import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:vishwakarmas/core/providers/auth_provider.dart';
import 'package:vishwakarmas/core/services/navigation_service.dart';
import 'package:vishwakarmas/core/utils/app_theme.dart';
import 'package:vishwakarmas/localization/app_localizations.dart';
import 'package:vishwakarmas/routes.dart';
import 'package:vishwakarmas/ui/widgets/custom_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isRegistration;
  final String? name;
  final int? userType;

  const OtpVerificationScreen({
    Key? key,
    required this.phoneNumber,
    this.isRegistration = false,
    this.name,
    this.userType,
  }) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  int _resendTime = 30;
  late Timer _timer;
  bool _hasError = false;
  String _errorText = '';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _resendTime = 30;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_resendTime == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _resendTime--;
          });
        }
      },
    );
  }

  Future<void> _resendOTP() async {
    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.sendOTP(widget.phoneNumber);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      _startTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP resent successfully to ${widget.phoneNumber}'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.error ?? 'Failed to resend OTP'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _verifyOTP() async {
    if (_otpController.text.length != 6) {
      setState(() {
        _hasError = true;
        _errorText = 'Please enter a valid 6-digit OTP';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool success;

    if (widget.isRegistration) {
      // Registration flow
      success = await authProvider.register(
        name: widget.name!,
        phoneNumber: widget.phoneNumber,
        otp: _otpController.text,
        userType: widget.userType!,
      );
    } else {
      // Login flow
      success = await authProvider.verifyOTP(widget.phoneNumber, _otpController.text);
    }

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // Navigate to home screen
      NavigationService.navigateToAndRemoveUntil(AppRoutes.home);
    } else {
      setState(() {
        _hasError = true;
        _errorText = authProvider.error ?? 'Invalid OTP. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)?.translate ?? (String key) => key;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('otp_verification')),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      // OTP Icon
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.security,
                          size: 50,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Title
                      Text(
                        translate('enter_otp'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      // Subtitle with phone number
                      Text(
                        'We have sent an OTP to ${widget.phoneNumber}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      // OTP Pin Code Input
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        obscureText: false,
                        controller: _otpController,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 50,
                          fieldWidth: 45,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                          activeColor: _hasError ? Colors.red : AppTheme.primaryColor,
                          inactiveColor: Colors.grey.shade300,
                          selectedColor: AppTheme.primaryColor,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          // Auto verify when completed
                          _verifyOTP();
                        },
                        onChanged: (value) {
                          setState(() {
                            _hasError = false;
                          });
                        },
                        beforeTextPaste: (text) {
                          // Allow only digits
                          return text?.contains(RegExp(r'^[0-9]+$')) ?? false;
                        },
                      ),
                      if (_hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _errorText,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                      // Resend OTP
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            translate('didnt_receive_otp'),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: _resendTime == 0 ? _resendOTP : null,
                            child: Text(
                              _resendTime == 0
                                  ? translate('resend_otp')
                                  : '${translate('resend_otp')} (${_resendTime}s)',
                              style: TextStyle(
                                color: _resendTime == 0 ? AppTheme.primaryColor : Colors.grey,
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
              // Verify Button
              CustomButton(
                onPressed: _isLoading ? null : _verifyOTP,
                text: translate('verify_otp'),
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
