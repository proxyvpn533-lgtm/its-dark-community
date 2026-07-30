import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../screens/report/report_screen.dart';
import '../screens/suggestion/suggestion_screen.dart';
import '../screens/request/request_screen.dart';
import '../screens/top_requests/top_requests_screen.dart';
import '../screens/submissions/submissions_screen.dart';
import '../screens/settings/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primary, AppTheme.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(FontAwesomeIcons.circleNodes, size: 42, color: Colors.white),
                SizedBox(height: 12),
                Text(
                  'ITS DARK COMMUNITY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  'v1.0.0 • Production Release',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          _drawerItem(
            context,
            icon: FontAwesomeIcons.house,
            title: 'Home',
            onTap: () => Navigator.pop(context),
          ),
          _drawerItem(
            context,
            icon: FontAwesomeIcons.triangleExclamation,
            title: 'Report Issue',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportScreen()));
            },
          ),
          _drawerItem(
            context,
            icon: FontAwesomeIcons.lightbulb,
            title: 'Suggestion',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SuggestionScreen()));
            },
          ),
          _drawerItem(
            context,
            icon: FontAwesomeIcons.codeRequest,
            title: 'Request',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const RequestScreen()));
            },
          ),
          _drawerItem(
            context,
            icon: FontAwesomeIcons.fire,
            title: 'Top Requests',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const TopRequestsScreen()));
            },
          ),
          _drawerItem(
            context,
            icon: FontAwesomeIcons.boxArchive,
            title: 'My Submissions',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SubmissionsScreen()));
            },
          ),
          const Divider(color: AppTheme.divider),
          _drawerItem(
            context,
            icon: FontAwesomeIcons.gear,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          ),
          _drawerItem(
            context,
            icon: FontAwesomeIcons.circleInfo,
            title: 'About',
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationName: 'Its Dark Community',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(FontAwesomeIcons.circleNodes, color: AppTheme.primary, size: 32),
                children: [
                  const Text('Built for creators, developers, and power users. Shape the future of content directly.'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.accent, size: 20),
      title: Text(title, style: const TextStyle(color: AppTheme.text, fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }
}
