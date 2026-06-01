import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  late final FirebaseAuth auth;
  late final FirebaseFirestore firestore;
  late final FirebaseStorage storage;
  late final FirebaseMessaging messaging;

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
    storage = FirebaseStorage.instance;
    messaging = FirebaseMessaging.instance;

    auth.setLanguageCode('ar');

    firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );

    _initialized = true;
  }

  User? get currentUser => auth.currentUser;
  Stream<User?> get authStateChanges => auth.authStateChanges();
  bool get isLoggedIn => auth.currentUser != null;

  // ===== Collections =====
  CollectionReference get usersCol => firestore.collection('users');
  CollectionReference get doctorsCol => firestore.collection('doctors');
  CollectionReference get appointmentsCol => firestore.collection('appointments');
  CollectionReference get medicationsCol => firestore.collection('medications');
  CollectionReference get ordersCol => firestore.collection('orders');
  CollectionReference get reviewsCol => firestore.collection('reviews');
  CollectionReference get messagesCol => firestore.collection('messages');
  CollectionReference get subscriptionsCol => firestore.collection('subscriptions');
  CollectionReference get notificationsCol => firestore.collection('notifications');

  // User subcollections
  DocumentReference userDoc(String uid) => usersCol.doc(uid);
  CollectionReference userFavorites(String uid) => userDoc(uid).collection('favorites');
  CollectionReference userCart(String uid) => userDoc(uid).collection('cart');
}
