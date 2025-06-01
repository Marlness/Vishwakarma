import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vishwakarmas/core/constants/app_constants.dart';
import 'package:vishwakarmas/core/providers/app_provider.dart';
import 'package:vishwakarmas/core/providers/auth_provider.dart';
import 'package:vishwakarmas/core/services/navigation_service.dart';
import 'package:vishwakarmas/core/utils/app_theme.dart';
import 'package:vishwakarmas/localization/app_localizations.dart';
import 'package:vishwakarmas/routes.dart';
import 'package:vishwakarmas/ui/widgets/profession_category_card.dart';
import 'package:vishwakarmas/ui/widgets/service_card.dart';
import 'package:vishwakarmas/ui/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)?.translate ?? (String key) => key;
    final authProvider = Provider.of<AuthProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppConstants.appName),
            if (authProvider.currentUser != null)
              Text(
                "${translate('welcome')}, ${authProvider.currentUser!.name}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
          IconButton(
            icon: Icon(appProvider.isDarkMode 
                ? Icons.light_mode_outlined 
                : Icons.dark_mode_outlined),
            onPressed: () {
              appProvider.toggleDarkMode();
            },
          ),
        ],
      ),
      body: _getBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: translate('home'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_bag_outlined),
            activeIcon: const Icon(Icons.shopping_bag),
            label: translate('marketplace'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.build_outlined),
            activeIcon: const Icon(Icons.build),
            label: translate('services'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: translate('profile'),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    
    switch (index) {
      case 0: // Home
        setState(() {
          _selectedIndex = index;
        });
        break;
      case 1: // Marketplace
        NavigationService.navigateTo(AppRoutes.marketplace);
        break;
      case 2: // Services
        NavigationService.navigateTo(AppRoutes.services);
        break;
      case 3: // Profile
        NavigationService.navigateTo(AppRoutes.profile);
        break;
    }
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return _buildHomeContent();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    final translate = AppLocalizations.of(context)?.translate ?? (String key) => key;
    final authProvider = Provider.of<AuthProvider>(context);
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: translate('search'),
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Traditional Professions
            Text(
              translate('traditional_professions'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AppConstants.traditionalProfessions.length,
                itemBuilder: (context, index) {
                  final profession = AppConstants.traditionalProfessions[index];
                  return ProfessionCategoryCard(
                    title: profession,
                    icon: _getProfessionIcon(profession),
                    onTap: () {
                      // Navigate to the profession-specific page
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            
            // Featured Products
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translate('featured_products'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    NavigationService.navigateTo(AppRoutes.marketplace);
                  },
                  child: Text(
                    translate('view_all'),
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Placeholder count
                itemBuilder: (context, index) {
                  // Placeholder product data
                  return ProductCard(
                    imageUrl: 'https://via.placeholder.com/150',
                    title: 'Product ${index + 1}',
                    price: (1000 + (index * 500)).toDouble(),
                    category: AppConstants.traditionalProfessions[index % AppConstants.traditionalProfessions.length],
                    onTap: () {
                      // Navigate to product detail
                      NavigationService.navigateTo(
                        AppRoutes.productDetail,
                        arguments: 'product_${index + 1}',
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            
            // Top Services
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translate('top_services'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    NavigationService.navigateTo(AppRoutes.services);
                  },
                  child: Text(
                    translate('view_all'),
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3, // Placeholder count
              itemBuilder: (context, index) {
                // Placeholder service data
                return ServiceCard(
                  imageUrl: 'https://via.placeholder.com/150',
                  title: 'Service ${index + 1}',
                  providerName: 'Provider ${index + 1}',
                  category: AppConstants.traditionalProfessions[index % AppConstants.traditionalProfessions.length],
                  rating: 4.5,
                  onTap: () {
                    // Navigate to service detail
                    NavigationService.navigateTo(
                      AppRoutes.serviceDetail,
                      arguments: 'service_${index + 1}',
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  IconData _getProfessionIcon(String profession) {
    switch (profession.toLowerCase()) {
      case 'goldsmiths':
        return Icons.diamond;
      case 'carpenters':
        return Icons.handyman;
      case 'sculptors':
        return Icons.architecture;
      case 'blacksmiths':
        return Icons.construction;
      case 'bronzesmiths':
        return Icons.cast;
      default:
        return Icons.work;
    }
  }
}
