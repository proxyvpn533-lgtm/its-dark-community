import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/firebase_service.dart';
import '../../models/community_item.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  final _textController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;
  int _charLength = 0;

  void _submit() async {
    if (_textController.text.trim().isEmpty) return;

    setState(() => _isLoading = true);
    try {
      await _firebaseService.submitItem(
        title: 'Community Suggestion',
        description: _textController.text.trim(),
        category: 'General',
        priority: 'Normal',
        type: SubmissionType.suggestion,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Suggestion submitted! Thanks for feedback.')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Suggestion')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How can we improve the channel or app?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _textController,
              maxLines: 8,
              maxLength: 500,
              onChanged: (v) => setState(() => _charLength = v.length),
              decoration: const InputDecoration(
                hintText: 'Share your ideas, video topics, software improvements...',
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isLoading || _charLength == 0 ? null : _submit,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
