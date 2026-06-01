import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

class FirestoreService {
  final FirebaseService _firebase = FirebaseService();
  
  // ============ المستخدمين ============
  
  // إنشاء/تحديث مستخدم
  Future<void> saveUser({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await _firebase.userDoc(uid).set(data, SetOptions(merge: true));
  }
  
  // الحصول على مستخدم
  Future<DocumentSnapshot> getUser(String uid) async {
    return await _firebase.userDoc(uid).get();
  }
  
  // الاستماع لبيانات المستخدم
  Stream<DocumentSnapshot> userStream(String uid) {
    return _firebase.userDoc(uid).snapshots();
  }
  
  // تحديث بيانات المستخدم
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _firebase.userDoc(uid).update(data);
  }
  
  // ============ الأطباء ============
  
  // الحصول على جميع الأطباء
  Stream<QuerySnapshot> getDoctors({
    String? specialization,
    String? searchQuery,
    String sortBy = 'rating',
  }) {
    Query query = _firebase.doctorsCol.where('isAvailable', isEqualTo: true);
    
    if (specialization != null && specialization.isNotEmpty) {
      query = query.where('specialization', isEqualTo: specialization);
    }
    
    if (searchQuery != null && searchQuery.isNotEmpty) {
      query = query
          .where('fullName', isGreaterThanOrEqualTo: searchQuery)
          .where('fullName', isLessThanOrEqualTo: '$searchQuery\uf8ff');
    }
    
    switch (sortBy) {
      case 'price_low':
        query = query.orderBy('consultationPrice', descending: false);
        break;
      case 'price_high':
        query = query.orderBy('consultationPrice', descending: true);
        break;
      case 'experience':
        query = query.orderBy('experience', descending: true);
        break;
      default:
        query = query.orderBy('rating', descending: true);
    }
    
    return query.snapshots();
  }
  
  // الحصول على طبيب محدد
  Future<DocumentSnapshot> getDoctorById(String doctorId) async {
    return await _firebase.doctorDoc(doctorId).get();
  }
  
  // الحصول على التخصصات
  Stream<QuerySnapshot> getSpecializations() {
    return _firebase.firestore.collection('specializations').snapshots();
  }
  
  // ============ المواعيد ============
  
  // حجز موعد
  Future<String> bookAppointment(Map<String, dynamic> data) async {
    final docRef = await _firebase.appointmentsCol.add({
      ...data,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }
  
  // مواعيد المريض
  Stream<QuerySnapshot> getPatientAppointments(String patientId) {
    return _firebase.appointmentsCol
        .where('patientId', isEqualTo: patientId)
        .orderBy('date', descending: true)
        .snapshots();
  }
  
  // مواعيد قادمة
  Stream<QuerySnapshot> getUpcomingAppointments(String patientId) {
    final today = DateTime.now().toIso8601String().split('T')[0];
    return _firebase.appointmentsCol
        .where('patientId', isEqualTo: patientId)
        .where('date', isGreaterThanOrEqualTo: today)
        .where('status', whereIn: ['pending', 'confirmed'])
        .orderBy('date')
        .orderBy('time')
        .snapshots();
  }
  
  // إلغاء موعد
  Future<void> cancelAppointment(String appointmentId) async {
    await _firebase.appointmentsCol.doc(appointmentId).update({
      'status': 'cancelled',
    });
  }
  
  // ============ الأدوية والصيدلية ============
  
  // الحصول على الأدوية
  Stream<QuerySnapshot> getMedications({
    String? category,
    String? searchQuery,
  }) {
    Query query = _firebase.medicationsCol.where('inStock', isEqualTo: true);
    
    if (category != null && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }
    
    if (searchQuery != null && searchQuery.isNotEmpty) {
      query = query
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThanOrEqualTo: '$searchQuery\uf8ff');
    }
    
    return query.orderBy('name').snapshots();
  }
  
  // إضافة للسلة
  Future<void> addToCart({
    required String userId,
    required String medicationId,
    required Map<String, dynamic> data,
    int quantity = 1,
  }) async {
    final cartRef = _firebase.userCart(userId).doc(medicationId);
    final cartDoc = await cartRef.get();
    
    if (cartDoc.exists) {
      await cartRef.update({'quantity': FieldValue.increment(quantity)});
    } else {
      await cartRef.set({
        ...data,
        'quantity': quantity,
        'addedAt': FieldValue.serverTimestamp(),
      });
    }
  }
  
  // الحصول على السلة
  Stream<QuerySnapshot> getCartItems(String userId) {
    return _firebase.userCart(userId).snapshots();
  }
  
  // حذف من السلة
  Future<void> removeFromCart(String userId, String medicationId) async {
    await _firebase.userCart(userId).doc(medicationId).delete();
  }
  
  // إنشاء طلب
  Future<String> createOrder(Map<String, dynamic> data) async {
    final docRef = await _firebase.ordersCol.add({
      ...data,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }
  
  // طلبات المستخدم
  Stream<QuerySnapshot> getUserOrders(String userId) {
    return _firebase.ordersCol
        .where('patientId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
  
  // ============ التقييمات ============
  
  // إضافة تقييم
  Future<void> addReview(Map<String, dynamic> data) async {
    await _firebase.reviewsCol.add({
      ...data,
      'createdAt': FieldValue.serverTimestamp(),
    });
    
    // تحديث تقييم الطبيب
    await _updateDoctorRating(data['doctorId']);
  }
  
  // تقييمات طبيب
  Stream<QuerySnapshot> getDoctorReviews(String doctorId) {
    return _firebase.reviewsCol
        .where('doctorId', isEqualTo: doctorId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
  
  // تحديث تقييم الطبيب
  Future<void> _updateDoctorRating(String doctorId) async {
    final reviews = await _firebase.reviewsCol
        .where('doctorId', isEqualTo: doctorId)
        .get();
    
    if (reviews.docs.isEmpty) return;
    
    double total = 0;
    for (var doc in reviews.docs) {
      total += (doc['rating'] as num).toDouble();
    }
    
    final avgRating = total / reviews.docs.length;
    await _firebase.doctorDoc(doctorId).update({
      'rating': double.parse(avgRating.toStringAsFixed(1)),
      'totalReviews': reviews.docs.length,
    });
  }
  
  // ============ الرسائل ============
  
  // إرسال رسالة
  Future<void> sendMessage(Map<String, dynamic> data) async {
    await _firebase.messagesCol.add({
      ...data,
      'isRead': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
  
  // رسائل المحادثة
  Stream<QuerySnapshot> getMessages(String userId1, String userId2) {
    return _firebase.messagesCol
        .where('participants', arrayContains: userId1)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots();
  }
  
  // ============ الإشعارات ============
  
  // إرسال إشعار
  Future<void> sendNotification(Map<String, dynamic> data) async {
    await _firebase.notificationsCol.add({
      ...data,
      'isRead': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
  
  // إشعارات المستخدم
  Stream<QuerySnapshot> getUserNotifications(String userId) {
    return _firebase.notificationsCol
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots();
  }
  
  // تعليم كمقروء
  Future<void> markNotificationRead(String notificationId) async {
    await _firebase.notificationsCol.doc(notificationId).update({
      'isRead': true,
    });
  }
  
  // ============ الاشتراكات ============
  
  // خطط الاشتراك
  Stream<QuerySnapshot> getSubscriptionPlans() {
    return _firebase.firestore.collection('subscription_plans').snapshots();
  }
  
  // اشتراكات المستخدم
  Stream<QuerySnapshot> getUserSubscriptions(String userId) {
    return _firebase.subscriptionsCol
        .where('userId', isEqualTo: userId)
        .orderBy('startDate', descending: true)
        .snapshots();
  }
  
  // إنشاء اشتراك
  Future<String> createSubscription(Map<String, dynamic> data) async {
    final docRef = await _firebase.subscriptionsCol.add({
      ...data,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }
  
  // ============ الطوارئ ============
  
  // أرقام الطوارئ
  Stream<QuerySnapshot> getEmergencyNumbers() {
    return _firebase.firestore.collection('emergency_numbers').snapshots();
  }
  
  // مستشفيات قريبة
  Stream<QuerySnapshot> getNearbyHospitals() {
    return _firebase.firestore.collection('hospitals').snapshots();
  }
  
  // ============ التأمين ============
  
  // شركات التأمين
  Stream<QuerySnapshot> getInsuranceCompanies() {
    return _firebase.insuranceCol.snapshots();
  }
  
  // ============ السجل الطبي ============
  
  // إضافة للسجل الطبي
  Future<void> addToMedicalHistory(String userId, Map<String, dynamic> data) async {
    await _firebase.userMedicalHistory(userId).add({
      ...data,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
  
  // السجل الطبي
  Stream<QuerySnapshot> getMedicalHistory(String userId) {
    return _firebase.userMedicalHistory(userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
  
  // ============ المؤشرات الحيوية ============
  
  // إضافة مؤشر حيوي
  Future<void> addHealthMetric(String userId, Map<String, dynamic> data) async {
    await _firebase.userMetrics(userId).add({
      ...data,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
  
  // المؤشرات الحيوية
  Stream<QuerySnapshot> getHealthMetrics(String userId) {
    return _firebase.userMetrics(userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
