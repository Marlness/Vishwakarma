import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vishwakarmas/core/constants/app_constants.dart';
import 'package:vishwakarmas/core/providers/auth_provider.dart';
import 'package:vishwakarmas/core/services/navigation_service.dart';
import 'package:vishwakarmas/core/utils/app_theme.dart';
import 'package:vishwakarmas/localization/app_localizations.dart';
import 'package:vishwakarmas/routes.dart';
import 'package:vishwakarmas/ui/widgets/service_card.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)?.translate ?? (String key) => key;
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('services')),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterModal(context);
            },
          ),
        ],
      ),
      floatingActionButton: authProvider.isCommunityMember() 
          ? FloatingActionButton(
              onPressed: () {
                // Navigate to add service screen
              },
              backgroundColor: AppTheme.primaryColor,
              child: const Icon(Icons.add),
            )
          : null,
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: translate('search_services'),
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                  if (_searchQuery.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          _searchQuery = '';
                          _searchController.clear();
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
          
          // Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryChip('All', translate('all')),
                  ...AppConstants.traditionalProfessions.map((profession) {
                    return _buildCategoryChip(
                      profession, 
                      translate(profession.toLowerCase())
                    );
                  }),
                ],
              ),
            ),
          ),
          
          // Services
          Expanded(
            child: _buildServicesList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryChip(String category, String label) {
    final isSelected = _selectedCategory == category;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
  
  Widget _buildServicesList() {
    // This would normally fetch data from a backend service
    // For now, we'll use dummy data
    final services = List.generate(15, (index) {
      final profession = AppConstants.traditionalProfessions[index % AppConstants.traditionalProfessions.length];
      return {
        'id': 'service_$index',
        'title': 'Service ${index + 1}',
        'providerName': 'Provider ${index + 1}',
        'category': profession,
        'imageUrl': 'https://via.placeholder.com/150',
        'rating': 4.0 + (index % 11) / 10, // Rating between 4.0 and 5.0
      };
    });
    
    // Filter services based on category and search query
    final filteredServices = services.where((service) {
      final matchesCategory = _selectedCategory == 'All' || service['category'] == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty || 
          service['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          service['providerName'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
    
    if (filteredServices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text(
              'No services found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredServices.length,
      itemBuilder: (context, index) {
        final service = filteredServices[index];
        return ServiceCard(
          imageUrl: service['imageUrl'] as String,
          title: service['title'] as String,
          providerName: service['providerName'] as String,
          category: service['category'] as String,
          rating: service['rating'] as double,
          onTap: () {
            NavigationService.navigateTo(
              AppRoutes.serviceDetail,
              arguments: service['id'],
            );
          },
        );
      },
    );
  }
  
  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Rating: High to Low'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement sorting logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: const Text('Newest First'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement sorting logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Nearby First'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement sorting logic
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
