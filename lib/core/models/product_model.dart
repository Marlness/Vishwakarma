class ProductModel {
  final String? id;
  final String userId;
  final String title;
  final String description;
  final double price;
  final String category; // One of the 5 traditional professions
  final List<String> images;
  final bool isAvailable;
  final Map<String, dynamic>? specifications;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.images,
    required this.isAvailable,
    this.specifications,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: json['category'],
      images: List<String>.from(json['images']),
      isAvailable: json['isAvailable'],
      specifications: json['specifications'],
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
      'price': price,
      'category': category,
      'images': images,
      'isAvailable': isAvailable,
      'specifications': specifications,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
