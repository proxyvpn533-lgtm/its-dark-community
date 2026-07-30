import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/app_theme.dart';
import '../main_wrapper.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primary.withOpacity(0.3),
              ),
            ).animate().scale(duration: 2.seconds, curve: Curves.easeInOut),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  const Icon(FontAwesomeIcons.grip, size: 48, color: AppTheme.accent),
                  const SizedBox(height: 24),
                  const Text(
                    'ITS DARK\nCOMMUNITY',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.black,
                      height: 1.1,
                      letterSpacing: 1.5,
                    ),
                  ).animate().fadeIn().slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 16),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 20, color: AppTheme.textSecondary, height: 1.4),
                      children: [
                        TextSpan(text: 'Your '),
                        TextSpan(text: 'Feedback.\n', style: TextStyle(color: AppTheme.text, fontWeight: FontWeight.bold)),
                        TextSpan(text: 'My '),
                        TextSpan(text: 'Improvement.\n', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                        TextSpan(text: "Let's "),
                        TextSpan(text: 'Grow Together.', style: TextStyle(color: AppTheme.accent, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MainWrapper()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: AppTheme.primary.withOpacity(0.5),
                      elevation: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Get Started'),
                        SizedBox(width: 8),
                        Icon(FontAwesomeIcons.arrowRight, size: 16),
                      ],
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.5, end: 0),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
