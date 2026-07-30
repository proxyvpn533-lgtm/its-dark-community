import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import '../report/report_screen.dart';
import '../suggestion/suggestion_screen.dart';
import '../request/request_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ITS DARK COMMUNITY'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.bell),
            onPressed: () {
              // Action handled by bottom bar or top icon
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Header
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppTheme.primary,
                  radius: 22,
                  child: Icon(FontAwesomeIcons.user, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Welcome back,', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                    Text('Creator & Supporter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Featured Banner
            Card(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppTheme.radius),
                  gradient: const LinearGradient(
                    colors: [AppTheme.primary, Color(0xFF4C1D95)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('FEATURED VIDEO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.accent)),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Building Production Level Apps with Flutter & Firebase',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Check out the latest architecture, UI/UX polish, and deployment strategies.',
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(120, 40),
                      ),
                      onPressed: () => _launchURL('https://youtube.com'),
                      icon: const Icon(FontAwesomeIcons.youtube, color: Colors.red, size: 18),
                      label: const Text('Watch Now', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions
            const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                _actionCard(context, 'Report', FontAwesomeIcons.triangleExclamation, const ReportScreen()),
                const SizedBox(width: 12),
                _actionCard(context, 'Suggest', FontAwesomeIcons.lightbulb, const SuggestionScreen()),
                const SizedBox(width: 12),
                _actionCard(context, 'Request', FontAwesomeIcons.codeRequest, const RequestScreen()),
              ],
            ),
            const SizedBox(height: 24),

            // Latest Announcement
            const Text('Latest Announcement', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.card,
                borderRadius: BorderRadius.circular(AppTheme.radius),
                border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
              ),
              child: Row(
                children: const [
                  Icon(FontAwesomeIcons.bullhorn, color: AppTheme.accent),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'v1.0 Release is live! Submit your video and feature requests now.',
                      style: TextStyle(fontSize: 13, height: 1.3),
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

  Widget _actionCard(BuildContext context, String title, IconData icon, Widget target) {
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => target)),
        borderRadius: BorderRadius.circular(AppTheme.radius),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: AppTheme.card,
            borderRadius: BorderRadius.circular(AppTheme.radius),
            border: Border.all(color: AppTheme.divider),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppTheme.primary, size: 24),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
