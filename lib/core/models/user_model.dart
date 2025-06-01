class UserModel {
  final String? id;
  final String name;
  final String phoneNumber;
  final int userType; // Admin, Community Member, or General Public
  final String? temple; // ನಿಮ್ಮ ದೇವಸ್ಥಾನ/ ಕೂಡುವಳಿಕೆ/ಪ್ರಾಂತ್ಯ - YOUR TEMPLE/ KOODUVALIKE/ PROVINCE
  final String? gender; // ಲಿಂಗ - GENDER
  final String? aadharNo;
  final String? fatherName; // ತಂದೆಯ ಹೆಸರು - FATHER NAME
  final String? motherName; // ತಾಯಿಯ ಹೆಸರು - MOTHER NAME
  final String? relationWithHead; // Relationship with Head of the Home
  final String? gothra; // ಗೋತ್ರ - GOTHRA
  final DateTime? dateOfBirth;
  final String? education; // ವಿದ್ಯಾಭ್ಯಾಸ - EDUCATION
  final String? upanayana; // ಉಪನಯನ / UPANAYANA
  final String? marriageStatus; // ಮದುವೆ /MARRIAGE
  final String? spouseName; // ಗಂಡನ/ ಹೆಂಡತಿಯ ಹೆಸರು / Husband / Wife Name
  final String? children; // ಮಕ್ಕಳು / Children
  final int? boysCount; // ಗಂಡು ಮಕ್ಕಳ ಸಂಖ್ಯೆ/ Number of Boy Children
  final int? girlsCount; // ಹೆಣ್ಣು ಮಕ್ಕಳ ಸಂಖ್ಯೆ/ Number of Girl Children
  final String? employment; // ಉದ್ಯೋಗ/ Employment
  final String? annualIncome; // ವಾರ್ಷಿಕ ಆದಾಯ - ANNUAL INCOME
  final bool? isTaxPayer; // ತೆರಿಗೆದಾರರು /TAX PAYER
  final bool? hasVehicle; // ವಾಹನ /VEHICLE
  final bool? hasMedicalInsurance; // ನೀವು ವೈದ್ಯಕೀಯ ವಿಮೆ ಹೊಂದಿದ್ದೀರಾ? /Do you have medical insurance?
  final String? houseOwnership; // ಮನೆ - HOUSE
  final String? houseAddress; // ಮನೆ ವಿಳಾಸ/ House Address
  final String? ancestralHome; // ಕುಟುಂಬದ ಮನೆ (ತರವಾಡು)
  final String? rationCard; // ರೇಷನ್ ಕಾರ್ಡ್ - Ration Card
  final bool? isSpecialPerson; // Are you Special person (Disability) - ವಿಶೇಷ ಚೇತನರೇ
  final String? whatsappNumber; // ವಾಟ್ಸಪ್‌ ಸಂಖ್ಯೆ - WHATSAPP NUMBER
  final String? profilePicUrl; // ಭಾವ ಚಿತ್ರ/ Profile Picture
  final String? profession; // One of the 5 traditional professions if applicable
  final List<String>? skills; // Skills related to their profession
  final List<Map<String, dynamic>>? products; // Products they offer (for marketplace)
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.userType,
    this.temple,
    this.gender,
    this.aadharNo,
    this.fatherName,
    this.motherName,
    this.relationWithHead,
    this.gothra,
    this.dateOfBirth,
    this.education,
    this.upanayana,
    this.marriageStatus,
    this.spouseName,
    this.children,
    this.boysCount,
    this.girlsCount,
    this.employment,
    this.annualIncome,
    this.isTaxPayer,
    this.hasVehicle,
    this.hasMedicalInsurance,
    this.houseOwnership,
    this.houseAddress,
    this.ancestralHome,
    this.rationCard,
    this.isSpecialPerson,
    this.whatsappNumber,
    this.profilePicUrl,
    this.profession,
    this.skills,
    this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      userType: json['userType'],
      temple: json['temple'],
      gender: json['gender'],
      aadharNo: json['aadharNo'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      relationWithHead: json['relationWithHead'],
      gothra: json['gothra'],
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      education: json['education'],
      upanayana: json['upanayana'],
      marriageStatus: json['marriageStatus'],
      spouseName: json['spouseName'],
      children: json['children'],
      boysCount: json['boysCount'],
      girlsCount: json['girlsCount'],
      employment: json['employment'],
      annualIncome: json['annualIncome'],
      isTaxPayer: json['isTaxPayer'],
      hasVehicle: json['hasVehicle'],
      hasMedicalInsurance: json['hasMedicalInsurance'],
      houseOwnership: json['houseOwnership'],
      houseAddress: json['houseAddress'],
      ancestralHome: json['ancestralHome'],
      rationCard: json['rationCard'],
      isSpecialPerson: json['isSpecialPerson'],
      whatsappNumber: json['whatsappNumber'],
      profilePicUrl: json['profilePicUrl'],
      profession: json['profession'],
      skills: json['skills'] != null ? List<String>.from(json['skills']) : null,
      products: json['products'] != null ? List<Map<String, dynamic>>.from(json['products']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'userType': userType,
      'temple': temple,
      'gender': gender,
      'aadharNo': aadharNo,
      'fatherName': fatherName,
      'motherName': motherName,
      'relationWithHead': relationWithHead,
      'gothra': gothra,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'education': education,
      'upanayana': upanayana,
      'marriageStatus': marriageStatus,
      'spouseName': spouseName,
      'children': children,
      'boysCount': boysCount,
      'girlsCount': girlsCount,
      'employment': employment,
      'annualIncome': annualIncome,
      'isTaxPayer': isTaxPayer,
      'hasVehicle': hasVehicle,
      'hasMedicalInsurance': hasMedicalInsurance,
      'houseOwnership': houseOwnership,
      'houseAddress': houseAddress,
      'ancestralHome': ancestralHome,
      'rationCard': rationCard,
      'isSpecialPerson': isSpecialPerson,
      'whatsappNumber': whatsappNumber,
      'profilePicUrl': profilePicUrl,
      'profession': profession,
      'skills': skills,
      'products': products,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    int? userType,
    String? temple,
    String? gender,
    String? aadharNo,
    String? fatherName,
    String? motherName,
    String? relationWithHead,
    String? gothra,
    DateTime? dateOfBirth,
    String? education,
    String? upanayana,
    String? marriageStatus,
    String? spouseName,
    String? children,
    int? boysCount,
    int? girlsCount,
    String? employment,
    String? annualIncome,
    bool? isTaxPayer,
    bool? hasVehicle,
    bool? hasMedicalInsurance,
    String? houseOwnership,
    String? houseAddress,
    String? ancestralHome,
    String? rationCard,
    bool? isSpecialPerson,
    String? whatsappNumber,
    String? profilePicUrl,
    String? profession,
    List<String>? skills,
    List<Map<String, dynamic>>? products,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userType: userType ?? this.userType,
      temple: temple ?? this.temple,
      gender: gender ?? this.gender,
      aadharNo: aadharNo ?? this.aadharNo,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      relationWithHead: relationWithHead ?? this.relationWithHead,
      gothra: gothra ?? this.gothra,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      education: education ?? this.education,
      upanayana: upanayana ?? this.upanayana,
      marriageStatus: marriageStatus ?? this.marriageStatus,
      spouseName: spouseName ?? this.spouseName,
      children: children ?? this.children,
      boysCount: boysCount ?? this.boysCount,
      girlsCount: girlsCount ?? this.girlsCount,
      employment: employment ?? this.employment,
      annualIncome: annualIncome ?? this.annualIncome,
      isTaxPayer: isTaxPayer ?? this.isTaxPayer,
      hasVehicle: hasVehicle ?? this.hasVehicle,
      hasMedicalInsurance: hasMedicalInsurance ?? this.hasMedicalInsurance,
      houseOwnership: houseOwnership ?? this.houseOwnership,
      houseAddress: houseAddress ?? this.houseAddress,
      ancestralHome: ancestralHome ?? this.ancestralHome,
      rationCard: rationCard ?? this.rationCard,
      isSpecialPerson: isSpecialPerson ?? this.isSpecialPerson,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      profession: profession ?? this.profession,
      skills: skills ?? this.skills,
      products: products ?? this.products,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
