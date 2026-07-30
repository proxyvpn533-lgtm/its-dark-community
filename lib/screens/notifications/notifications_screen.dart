import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/app_theme.dart';
import '../../services/firebase_service.dart';
import '../../models/community_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService service = FirebaseService();

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: StreamBuilder<List<AppNotification>>(
        stream: service.getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final notifications = snapshot.data ?? [];

          if (notifications.isEmpty) {
            return const Center(
              child: Text('No new notifications.', style: TextStyle(color: AppTheme.textSecondary)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              return Dismissible(
                key: Key(notif.id),
                onDismissed: (_) => service.deleteNotification(notif.id),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(FontAwesomeIcons.trash, color: Colors.white),
                ),
                child: Card(
                  color: notif.isRead ? AppTheme.card : const Color(0xFF221533),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppTheme.primary,
                      child: Icon(FontAwesomeIcons.bell, color: Colors.white, size: 16),
                    ),
                    title: Text(notif.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(notif.body, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                    onTap: () => service.markNotificationRead(notif.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

