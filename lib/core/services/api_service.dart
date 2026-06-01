import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

/// خدمة API المعدلة للعمل مع Firebase Firestore
class ApiService {
  static final FirebaseService _fb = FirebaseService();

  // ========== AUTH ==========
  static Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    // يتم التعامل معها عبر AuthBloc مباشرة
    return {'success': true};
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    // يتم التعامل معها عبر AuthBloc مباشرة
    return {'success': true};
  }

  static Future<Map<String, dynamic>> getProfile() async {
    final uid = _fb.currentUser?.uid;
    if (uid == null) return {'success': false, 'message': 'غير مسجل'};
    final doc = await _fb.userDoc(uid).get();
    return {'success': true, 'data': doc.data()};
  }

  // ========== DOCTORS ==========
  static Future<List<Map<String, dynamic>>> getDoctors({String? specialty}) async {
    Query query = _fb.doctorsCol.where('isAvailable', isEqualTo: true);
    if (specialty != null) query = query.where('specialization', isEqualTo: specialty);
    query = query.orderBy('rating', descending: true);
    final snapshot = await query.get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // ========== ORDERS ==========
  static Future<Map<String, dynamic>> placeOrder({
    required Map<String, dynamic> details,
  }) async {
    final uid = _fb.currentUser?.uid;
    if (uid == null) return {'success': false};
    await _fb.ordersCol.add({...details, 'patientId': uid, 'createdAt': FieldValue.serverTimestamp()});
    return {'success': true};
  }

  // ========== NOTIFICATIONS ==========
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final uid = _fb.currentUser?.uid;
    if (uid == null) return [];
    final snapshot = await _fb.notificationsCol
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}
