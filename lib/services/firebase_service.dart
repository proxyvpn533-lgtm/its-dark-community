import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../models/community_item.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> init() async {
    if (_auth.currentUser == null) {
      await _auth.signInAnonymously();
    }
    await _fcm.requestPermission();
    
    // Ensure user record exists
    if (_auth.currentUser != null) {
      await _db.collection('users').doc(_auth.currentUser!.uid).set({
        'lastActive': FieldValue.serverTimestamp(),
        'fcmToken': await _fcm.getToken(),
      }, SetOptions(merge: true));
    }
  }

  // Submit Issue, Suggestion or Request
  Future<void> submitItem({
    required String title,
    required String description,
    required String category,
    required String priority,
    required SubmissionType type,
    String? imageUrl,
  }) async {
    final uid = _auth.currentUser?.uid ?? 'anonymous';
    final collection = type == SubmissionType.issue
        ? 'issues'
        : type == SubmissionType.suggestion
            ? 'suggestions'
            : 'requests';

    await _db.collection(collection).add({
      'userId': uid,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'type': type.name,
      'status': SubmissionStatus.open.name,
      'votes': 0,
      'createdAt': FieldValue.serverTimestamp(),
      'imageUrl': imageUrl,
    });
  }

  // Stream Top Requests
  Stream<List<CommunityItem>> getTopRequests() {
    return _db
        .collection('requests')
        .orderBy('votes', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => CommunityItem.fromFirestore(doc)).toList());
  }

  // Stream User Submissions
  Stream<List<CommunityItem>> getUserSubmissions(SubmissionType type) {
    final collection = type == SubmissionType.issue
        ? 'issues'
        : type == SubmissionType.suggestion
            ? 'suggestions'
            : 'requests';

    final uid = _auth.currentUser?.uid ?? '';
    return _db
        .collection(collection)
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => CommunityItem.fromFirestore(doc)).toList());
  }

  // Vote for Request
  Future<void> voteRequest(String id, int currentVotes) async {
    await _db.collection('requests').doc(id).update({
      'votes': currentVotes + 1,
    });
  }

  // Stream Notifications
  Stream<List<AppNotification>> getNotifications() {
    return _db
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => AppNotification.fromFirestore(doc)).toList());
  }

  Future<void> markNotificationRead(String id) async {
    await _db.collection('notifications').doc(id).update({'isRead': true});
  }

  Future<void> deleteNotification(String id) async {
    await _db.collection('notifications').doc(id).delete();
  }
}

