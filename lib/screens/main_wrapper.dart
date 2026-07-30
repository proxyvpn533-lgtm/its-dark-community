import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/app_provider.dart';
import '../widgets/app_drawer.dart';
import 'home/home_screen.dart';
import 'top_requests/top_requests_screen.dart';
import 'notifications/notifications_screen.dart';
import 'profile/profile_screen.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    TopRequestsScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      drawer: const AppDrawer(),
      body: IndexedStack(
        index: provider.selectedNavIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.selectedNavIndex,
        onTap: (index) => provider.setNavIndex(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house, size: 18),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.fire, size: 18),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bell, size: 18),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user, size: 18),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
