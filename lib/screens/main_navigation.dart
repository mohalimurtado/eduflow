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
            
            // Touch Targets
            SizedBox(
              height: 56, // The clickable area standard height
              child: Row(
                children: [
                  // Home Target
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onItemTapped(0),
                      behavior: HitTestBehavior.opaque,
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                  // Kelas Saya Target (Center)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onItemTapped(1),
                      behavior: HitTestBehavior.opaque,
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                  // Notifikasi Target
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onItemTapped(2),
                      behavior: HitTestBehavior.opaque,
                      child: Container(color: Colors.transparent),
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
}
