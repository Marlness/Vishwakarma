import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:vishwakarmas/core/constants/app_constants.dart';
import 'package:vishwakarmas/core/models/user_model.dart';
import 'package:vishwakarmas/core/providers/auth_provider.dart';
import 'package:vishwakarmas/core/utils/app_theme.dart';
import 'package:vishwakarmas/localization/app_localizations.dart';
import 'package:vishwakarmas/ui/widgets/custom_button.dart';
import 'package:vishwakarmas/ui/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';

class PersonalDetailsScreen extends StatefulWidget {
  final bool isEditing;

  const PersonalDetailsScreen({
    Key? key,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  // Form key and page controller
  final _formKey = GlobalKey<FormState>();
  late PageController _pageController;
  int _currentPage = 0;
  bool _isLoading = false;
  
  // Controllers for text fields
  final _templeController = TextEditingController();
  final _aadharController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _spouseNameController = TextEditingController();
  final _boysCountController = TextEditingController();
  final _girlsCountController = TextEditingController();
  final _houseAddressController = TextEditingController();
  final _ancestralHomeController = TextEditingController();
  final _whatsappNumberController = TextEditingController();
  
  // Selected values
  String? _selectedGender;
  String? _selectedRelationWithHead;
  String? _selectedGothra;
  String? _selectedEducation;
  String? _selectedUpanayana;
  String? _selectedMarriage;
  String? _selectedChildren;
  String? _selectedEmployment;
  String? _selectedIncome;
  bool? _isTaxPayer;
  bool? _hasVehicle;
  bool? _hasMedicalInsurance;
  String? _selectedHouseOwnership;
  String? _selectedRationCard;
  bool? _isSpecialPerson;
  
  // Profile image
  String? _profileImagePath;
  
  // Current user data
  late UserModel? _userData;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Load user data if available
      _userData = Provider.of<AuthProvider>(context, listen: false).currentUser;
      _loadUserData();
    });
  }
  
  void _loadUserData() {
    if (_userData != null) {
      // Basic Information
      _templeController.text = _userData?.temple ?? '';
      _selectedGender = _userData?.gender;
      _aadharController.text = _userData?.aadharNo ?? '';
      _fatherNameController.text = _userData?.fatherName ?? '';
      _motherNameController.text = _userData?.motherName ?? '';
      _selectedRelationWithHead = _userData?.relationWithHead;
      _selectedGothra = _userData?.gothra;
      
      // Date of Birth
      if (_userData?.dateOfBirth != null) {
        _dobController.text = DateFormat('dd/MM/yyyy').format(_userData!.dateOfBirth!);
      }
      
      // Education and Family
      _selectedEducation = _userData?.education;
      _selectedUpanayana = _userData?.upanayana;
      _selectedMarriage = _userData?.marriageStatus;
      _spouseNameController.text = _userData?.spouseName ?? '';
      _selectedChildren = _userData?.children;
      _boysCountController.text = _userData?.boysCount?.toString() ?? '';
      _girlsCountController.text = _userData?.girlsCount?.toString() ?? '';
      
      // Employment and Income
      _selectedEmployment = _userData?.employment;
      _selectedIncome = _userData?.annualIncome;
      _isTaxPayer = _userData?.isTaxPayer;
      _hasVehicle = _userData?.hasVehicle;
      _hasMedicalInsurance = _userData?.hasMedicalInsurance;
      
      // Housing and Contact
      _selectedHouseOwnership = _userData?.houseOwnership;
      _houseAddressController.text = _userData?.houseAddress ?? '';
      _ancestralHomeController.text = _userData?.ancestralHome ?? '';
      _selectedRationCard = _userData?.rationCard;
      _isSpecialPerson = _userData?.isSpecialPerson;
      _whatsappNumberController.text = _userData?.whatsappNumber ?? '';
      _profileImagePath = _userData?.profilePicUrl;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    
    // Dispose all controllers
    _templeController.dispose();
    _aadharController.dispose();
    _fatherNameController.dispose();
    _motherNameController.dispose();
    _dobController.dispose();
    _spouseNameController.dispose();
    _boysCountController.dispose();
    _girlsCountController.dispose();
    _houseAddressController.dispose();
    _ancestralHomeController.dispose();
    _whatsappNumberController.dispose();
    
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }
  
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _profileImagePath = image.path;
      });
      
      // TODO: Upload image to storage and get URL
    }
  }
  
  Future<void> _saveUserData() async {
    if (!_formKey.currentState!.validate()) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    // Create updated user model
    final updatedUser = UserModel(
      id: _userData?.id,
      name: _userData?.name ?? '',
      phoneNumber: _userData?.phoneNumber ?? '',
      userType: _userData?.userType ?? AppConstants.userTypeCommunityMember,
      temple: _templeController.text,
      gender: _selectedGender,
      aadharNo: _aadharController.text,
      fatherName: _fatherNameController.text,
      motherName: _motherNameController.text,
      relationWithHead: _selectedRelationWithHead,
      gothra: _selectedGothra,
      dateOfBirth: _dobController.text.isNotEmpty 
          ? DateFormat('dd/MM/yyyy').parse(_dobController.text) 
          : null,
      education: _selectedEducation,
      upanayana: _selectedUpanayana,
      marriageStatus: _selectedMarriage,
      spouseName: _spouseNameController.text,
      children: _selectedChildren,
      boysCount: _boysCountController.text.isNotEmpty 
          ? int.tryParse(_boysCountController.text) 
          : null,
      girlsCount: _girlsCountController.text.isNotEmpty 
          ? int.tryParse(_girlsCountController.text) 
          : null,
      employment: _selectedEmployment,
      annualIncome: _selectedIncome,
      isTaxPayer: _isTaxPayer,
      hasVehicle: _hasVehicle,
      hasMedicalInsurance: _hasMedicalInsurance,
      houseOwnership: _selectedHouseOwnership,
      houseAddress: _houseAddressController.text,
      ancestralHome: _ancestralHomeController.text,
      rationCard: _selectedRationCard,
      isSpecialPerson: _isSpecialPerson,
      whatsappNumber: _whatsappNumberController.text,
      profilePicUrl: _profileImagePath,
      createdAt: _userData?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    // Update user profile
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.updateProfile(updatedUser);
    
    setState(() {
      _isLoading = false;
    });
    
    if (success) {
      // Show success message and pop
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.pop(context);
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.error ?? 'Failed to update profile')),
      );
    }
  }
  
  void _nextPage() {
    if (_currentPage < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _saveUserData();
    }
  }
  
  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)?.translate ?? (String key) => key;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('personal_details')),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: List.generate(5, (index) {
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: index <= _currentPage 
                            ? AppTheme.primaryColor 
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),
            
            // Page content
            Expanded(
              child: Form(
                key: _formKey,
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    _buildBasicInfoPage(context),
                    // Using placeholder pages temporarily until fully implemented
                    _buildBasicInfoPage(context), // Temporarily replacing _buildFamilyInfoPage
                    _buildBasicInfoPage(context), // Temporarily replacing _buildEducationPage
                    _buildBasicInfoPage(context), // Temporarily replacing _buildEconomicStatusPage
                    _buildBasicInfoPage(context), // Temporarily replacing _buildContactInfoPage
                  ],
                ),
              ),
            ),
            
            // Navigation buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: CustomButton(
                        onPressed: _previousPage,
                        text: translate('previous'),
                        backgroundColor: Colors.grey.shade200,
                        textColor: Colors.black,
                      ),
                    ),
                  if (_currentPage > 0)
                    const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      onPressed: _nextPage,
                      text: _currentPage < 4 ? translate('next') : translate('save'),
                      isLoading: _isLoading,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Build separate pages for the form sections
  Widget _buildBasicInfoPage(BuildContext context) {
    final translate = AppLocalizations.of(context)?.translate ?? (String key) => key;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Title
          Text(
            translate('basic_information'),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          // Profile Picture
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      border: Border.all(color: AppTheme.primaryColor),
                      shape: BoxShape.circle,
                      image: _profileImagePath != null
                          ? DecorationImage(
                              image: (_profileImagePath!.startsWith('http')
                                  ? NetworkImage(_profileImagePath!)
                                  : AssetImage(_profileImagePath!)) as ImageProvider,
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _profileImagePath == null
                        ? const Icon(
                            Icons.camera_alt,
                            color: AppTheme.primaryColor,
                            size: 40,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  translate('profile_picture'),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Temple/Kooduvalike/Province
          CustomTextField(
            controller: _templeController,
            label: translate('temple'),
            validator: (value) {
              return null; // Optional field
            },
          ),
          const SizedBox(height: 16),
          
          // Gender
          Text(
            translate('gender'),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: AppConstants.genderTypes.entries.map((entry) {
              return Expanded(
                child: RadioListTile<String>(
                  title: Text(
                    entry.value.split(' - ').last,
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: entry.key,
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          
          // Aadhar Number
          CustomTextField(
            controller: _aadharController,
            label: translate('aadhar_no'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value != null && value.isNotEmpty && value.length != 12) {
                return 'Aadhar number must be 12 digits';
              }
              return null; // Optional field
            },
          ),
          const SizedBox(height: 16),
          
          // Father's Name
          CustomTextField(
            controller: _fatherNameController,
            label: translate('father_name'),
            validator: (value) {
              return null; // Optional field
            },
          ),
          const SizedBox(height: 16),
          
          // Mother's Name
          CustomTextField(
            controller: _motherNameController,
            label: translate('mother_name'),
            validator: (value) {
              return null; // Optional field
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // More pages to come in the continuous implementation...
}
