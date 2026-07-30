import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppTheme.primary,
              child: Icon(FontAwesomeIcons.userAstronaut, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Its Dark Official',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Tech Creator & Community Lead',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 30),

            // Social Link Buttons
            _socialButton(
              title: 'YouTube Channel',
              icon: FontAwesomeIcons.youtube,
              color: Colors.red,
              onTap: () => _launchURL('https://youtube.com'),
            ),
            const SizedBox(height: 12),
            _socialButton(
              title: 'Instagram',
              icon: FontAwesomeIcons.instagram,
              color: Colors.pink,
              onTap: () => _launchURL('https://instagram.com'),
            ),
            const SizedBox(height: 12),
            _socialButton(
              title: 'Discord Community',
              icon: FontAwesomeIcons.discord,
              color: const Color(0xFF5865F2),
              onTap: () => _launchURL('https://discord.com'),
            ),
            const SizedBox(height: 24),
            const Divider(color: AppTheme.divider),
            const SizedBox(height: 12),

            ListTile(
              leading: const Icon(FontAwesomeIcons.shareNodes, color: AppTheme.accent),
              title: const Text('Share App'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('App link copied to clipboard!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.star, color: Colors.amber),
              title: const Text('Rate on Play Store'),
              onTap: () => _launchURL('https://play.google.com'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton({required String title, required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radius),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.card,
          borderRadius: BorderRadius.circular(AppTheme.radius),
          border: Border.all(color: AppTheme.divider),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const Spacer(),
            const Icon(FontAwesomeIcons.chevronRight, size: 14, color: AppTheme.textSecondary),
          ],
        ),
      ),
    );
  }
}
