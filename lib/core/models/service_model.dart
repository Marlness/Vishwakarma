class ServiceModel {
  final String? id;
  final String userId;
  final String title;
  final String description;
  final String category; // One of the 5 traditional professions
  final List<String> images;
  final double hourlyRate;
  final bool isAvailable;
  final List<String> serviceAreas; // Areas where the service provider can work
  final Map<String, dynamic>? portfolio; // Previous work examples
  final DateTime createdAt;
  final DateTime updatedAt;

  ServiceModel({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.images,
    required this.hourlyRate,
    required this.isAvailable,
    required this.serviceAreas,
    this.portfolio,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      images: List<String>.from(json['images']),
      hourlyRate: json['hourlyRate'].toDouble(),
      isAvailable: json['isAvailable'],
      serviceAreas: List<String>.from(json['serviceAreas']),
      portfolio: json['portfolio'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'category': category,
      'images': images,
      'hourlyRate': hourlyRate,
      'isAvailable': isAvailable,
      'serviceAreas': serviceAreas,
      'portfolio': portfolio,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
