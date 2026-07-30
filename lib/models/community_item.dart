import 'package:cloud_firestore/cloud_firestore.dart';

enum SubmissionType { issue, suggestion, request }
enum SubmissionStatus { open, completed, rejected }

class CommunityItem {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String category;
  final String priority;
  final SubmissionType type;
  final SubmissionStatus status;
  final int votes;
  final DateTime createdAt;
  final String? imageUrl;

  CommunityItem({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.type,
    required this.status,
    required this.votes,
    required this.createdAt,
    this.imageUrl,
  });

  factory CommunityItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CommunityItem(
      id: doc.id,
      userId: data['userId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? 'General',
      priority: data['priority'] ?? 'Medium',
      type: SubmissionType.values.firstWhere(
        (e) => e.name == data['type'],
        orElse: () => SubmissionType.request,
      ),
      status: SubmissionStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => SubmissionStatus.open,
      ),
      votes: data['votes'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'type': type.name,
      'status': status.name,
      'votes': votes,
      'createdAt': Timestamp.fromDate(createdAt),
      'imageUrl': imageUrl,
    };
  }
}

class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
  });

  factory AppNotification.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppNotification(
      id: doc.id,
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isRead: data['isRead'] ?? false,
    );
  }
}

