import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            value: provider.darkMode,
            activeColor: AppTheme.primary,
            title: const Text('Dark Theme'),
            subtitle: const Text('Always dark as intended'),
            onChanged: (val) => provider.toggleDarkMode(val),
          ),
          SwitchListTile(
            value: provider.notificationsEnabled,
            activeColor: AppTheme.primary,
            title: const Text('Push Notifications'),
            subtitle: const Text('Get updates on feature requests'),
            onChanged: (val) => provider.toggleNotifications(val),
          ),
          const Divider(color: AppTheme.divider),
          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
