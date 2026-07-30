import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/app_theme.dart';
import '../../services/firebase_service.dart';
import '../../models/community_item.dart';

class TopRequestsScreen extends StatefulWidget {
  const TopRequestsScreen({super.key});

  @override
  State<TopRequestsScreen> createState() => _TopRequestsScreenState();
}

class _TopRequestsScreenState extends State<TopRequestsScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Community Requests')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
              decoration: const InputDecoration(
                hintText: 'Search requests...',
                prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass, size: 16),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<CommunityItem>>(
              stream: _firebaseService.getTopRequests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final items = (snapshot.data ?? []).where((item) {
                  return item.title.toLowerCase().contains(_searchQuery) ||
                      item.description.toLowerCase().contains(_searchQuery);
                }).toList();

                if (items.isEmpty) {
                  return const Center(
                    child: Text('No requests found.', style: TextStyle(color: AppTheme.textSecondary)),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: CircleAvatar(
                          backgroundColor: AppTheme.primary.withOpacity(0.2),
                          child: Text('#${index + 1}', style: const TextStyle(color: AppTheme.accent, fontWeight: FontWeight.bold)),
                        ),
                        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          item.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => _firebaseService.voteRequest(item.id, item.votes),
                              child: const Icon(FontAwesomeIcons.thumbsUp, color: AppTheme.primary, size: 18),
                            ),
                            const SizedBox(height: 4),
                            Text('${item.votes}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
