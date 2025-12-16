import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'my_classes_screen.dart';
import 'notification/notification_screen.dart';
import 'profile/profile_screen.dart';
// import 'notification_screen.dart';

import '../theme/app_colors.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}



class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MyClassesScreen(), // Use actual screen
    const NotificationScreen(), // Use actual screen
    const ProfileScreen(), // Use actual screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      // Floating Bottom Nav with fixed height as per design
      bottomNavigationBar: SizedBox(
        height: 56, // Exact 56px as requested
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Background Image
            Container(
              width: double.infinity,
              height: 56, // Matching container
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bottom_nav_bg.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            
            // Touch Targets & Icons
            SizedBox(
              height: 56, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home_rounded, 'Home', 0),
                  _buildNavItem(Icons.school_rounded, 'Kelas', 1),
                  _buildNavItem(Icons.notifications_rounded, 'Aktivitas', 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
              size: isSelected ? 26 : 24,
            ),
            if (isSelected) ...[
              const SizedBox(height: 4),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
