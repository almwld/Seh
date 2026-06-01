class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'https://api.sehatak.com/v1';
  static const String stagingBaseUrl = 'https://staging.sehatak.com/v1';
  static const String devBaseUrl = 'https://dev.sehatak.com/v1';

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyOTP = '/auth/verify-otp';
  static const String resendOTP = '/auth/resend-otp';
  static const String changePassword = '/auth/change-password';
  static const String biometricAuth = '/auth/biometric';
  static const String twoFactorAuth = '/auth/2fa';

  // User
  static const String userProfile = '/users/profile';
  static const String updateProfile = '/users/profile';
  static const String uploadAvatar = '/users/avatar';
  static const String deleteAccount = '/users/account';
  static const String userSettings = '/users/settings';
  static const String userNotifications = '/users/notifications';

  // Doctors
  static const String doctors = '/doctors';
  static const String doctorDetails = '/doctors/{id}';
  static const String doctorSchedule = '/doctors/{id}/schedule';
  static const String doctorReviews = '/doctors/{id}/reviews';
  static const String doctorAvailability = '/doctors/{id}/availability';
  static const String topDoctors = '/doctors/top';
  static const String doctorSpecialties = '/doctors/specialties';
  static const String searchDoctors = '/doctors/search';
  static const String doctorClinics = '/doctors/{id}/clinics';

  // Appointments
  static const String appointments = '/appointments';
  static const String appointmentDetails = '/appointments/{id}';
  static const String bookAppointment = '/appointments/book';
  static const String cancelAppointment = '/appointments/{id}/cancel';
  static const String rescheduleAppointment = '/appointments/{id}/reschedule';
  static const String appointmentHistory = '/appointments/history';
  static const String upcomingAppointments = '/appointments/upcoming';

  // Pharmacy
  static const String pharmacies = '/pharmacies';
  static const String pharmacyDetails = '/pharmacies/{id}';
  static const String pharmacyProducts = '/pharmacies/{id}/products';
  static const String productDetails = '/products/{id}';
  static const String productCategories = '/products/categories';
  static const String searchProducts = '/products/search';
  static const String cart = '/cart';
  static const String addToCart = '/cart/add';
  static const String removeFromCart = '/cart/remove';
  static const String updateCart = '/cart/update';
  static const String checkout = '/orders/checkout';
  static const String orders = '/orders';
  static const String orderDetails = '/orders/{id}';
  static const String orderTracking = '/orders/{id}/tracking';
  static const String prescriptions = '/prescriptions';
  static const String uploadPrescription = '/prescriptions/upload';

  // Lab
  static const String labs = '/labs';
  static const String labDetails = '/labs/{id}';
  static const String labTests = '/labs/{id}/tests';
  static const String testDetails = '/tests/{id}';
  static const String bookTest = '/tests/book';
  static const String testResults = '/tests/{id}/results';
  static const String labPackages = '/labs/packages';
  static const String homeVisit = '/labs/home-visit';

  // Insurance
  static const String insuranceCompanies = '/insurance/companies';
  static const String insuranceDetails = '/insurance/{id}';
  static const String insurancePlans = '/insurance/{id}/plans';
  static const String myInsurance = '/insurance/my';
  static const String submitClaim = '/insurance/claims';
  static const String claimStatus = '/insurance/claims/{id}';
  static const String claimHistory = '/insurance/claims/history';

  // Health
  static const String healthMetrics = '/health/metrics';
  static const String addHealthMetric = '/health/metrics';
  static const String healthHistory = '/health/history';
  static const String healthGoals = '/health/goals';
  static const String reminders = '/health/reminders';
  static const String addReminder = '/health/reminders';

  // Medical File
  static const String medicalHistory = '/medical/history';
  static const String diagnoses = '/medical/diagnoses';
  static const String medications = '/medical/medications';
  static const String allergies = '/medical/allergies';
  static const String surgeries = '/medical/surgeries';
  static const String vaccinations = '/medical/vaccinations';
  static const String medicalReports = '/medical/reports';
  static const String familyMembers = '/medical/family';

  // Payment
  static const String wallet = '/wallet';
  static const String walletTransactions = '/wallet/transactions';
  static const String addMoney = '/wallet/add';
  static const String withdraw = '/wallet/withdraw';
  static const String paymentMethods = '/payments/methods';
  static const String addPaymentMethod = '/payments/methods';
  static const String processPayment = '/payments/process';
  static const String paymentHistory = '/payments/history';
  static const String subscriptions = '/subscriptions';
  static const String subscriptionPlans = '/subscriptions/plans';

  // Emergency
  static const String emergencyNumbers = '/emergency/numbers';
  static const String nearbyHospitals = '/emergency/hospitals';
  static const String nearbyPharmacies = '/emergency/pharmacies';
  static const String firstAid = '/emergency/first-aid';
  static const String sos = '/emergency/sos';

  // Reports
  static const String reports = '/reports';
  static const String generateReport = '/reports/generate';
  static const String downloadReport = '/reports/{id}/download';

  // Notifications
  static const String notifications = '/notifications';
  static const String markAsRead = '/notifications/{id}/read';
  static const String markAllAsRead = '/notifications/read-all';
  static const String deleteNotification = '/notifications/{id}';

  // Search
  static const String search = '/search';
  static const String searchSuggestions = '/search/suggestions';
  static const String popularSearches = '/search/popular';

  // Upload
  static const String upload = '/upload';
  static const String uploadImage = '/upload/image';
  static const String uploadFile = '/upload/file';
  static const String uploadMultiple = '/upload/multiple';
}
