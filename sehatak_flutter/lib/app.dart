import 'package:flutter/material.dart';
import 'presentation/screens/auth/splash_screen.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/register_screen.dart';
import 'presentation/screens/auth/forgot_password_screen.dart';
import 'presentation/screens/auth/otp_verification_screen.dart';
import 'presentation/screens/auth/reset_password_screen.dart';
import 'presentation/screens/home/main_navigation.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/doctor/doctors_list_screen.dart';
import 'presentation/screens/doctor/doctor_details_screen.dart';
import 'presentation/screens/doctor/doctor_booking_screen.dart';
import 'presentation/screens/patient/patient_dashboard.dart';
import 'presentation/screens/patient/patient_profile.dart';
import 'presentation/screens/patient/patient_medical_history.dart';
import 'presentation/screens/patient/patient_appointments.dart';
import 'presentation/screens/patient/patient_prescriptions.dart';
import 'presentation/screens/pharmacy/pharmacies_list_screen.dart';
import 'presentation/screens/pharmacy/pharmacy_products_screen.dart';
import 'presentation/screens/pharmacy/cart_screen.dart';
import 'presentation/screens/lab/labs_list_screen.dart';
import 'presentation/screens/lab/lab_tests_screen.dart';
import 'presentation/screens/lab/test_booking_screen.dart';
import 'presentation/screens/insurance/insurance_companies.dart';
import 'presentation/screens/insurance/insurance_plans.dart';
import 'presentation/screens/health/health_dashboard.dart';
import 'presentation/screens/payment/wallet_screen.dart';
import 'presentation/screens/payment/payment_methods.dart';
import 'presentation/screens/emergencies/emergency_numbers.dart';
import 'presentation/screens/emergencies/sos_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';
import 'presentation/screens/reports/reports_dashboard.dart';
import 'presentation/screens/shared/notifications_screen.dart';
import 'presentation/screens/shared/search_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';
  static const String resetPassword = '/reset-password';
  static const String mainNav = '/main';
  static const String home = '/home';
  static const String doctorsList = '/doctors';
  static const String doctorDetails = '/doctor-details';
  static const String doctorBooking = '/doctor-booking';
  static const String patientDashboard = '/patient-dashboard';
  static const String patientProfile = '/patient-profile';
  static const String patientMedicalHistory = '/patient-medical-history';
  static const String patientAppointments = '/patient-appointments';
  static const String patientPrescriptions = '/patient-prescriptions';
  static const String pharmaciesList = '/pharmacies';
  static const String pharmacyProducts = '/pharmacy-products';
  static const String cart = '/cart';
  static const String labsList = '/labs';
  static const String labTests = '/lab-tests';
  static const String testBooking = '/test-booking';
  static const String insuranceCompanies = '/insurance';
  static const String insurancePlans = '/insurance-plans';
  static const String healthDashboard = '/health';
  static const String wallet = '/wallet';
  static const String paymentMethods = '/payment-methods';
  static const String emergencyNumbers = '/emergency';
  static const String sos = '/sos';
  static const String settings = '/settings';
  static const String reports = '/reports';
  static const String notifications = '/notifications';
  static const String search = '/search';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case otpVerification:
        final phone = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => OtpVerificationScreen(phone: phone ?? ''));
      case resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case mainNav:
        return MaterialPageRoute(builder: (_) => const MainNavigation());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case doctorsList:
        return MaterialPageRoute(builder: (_) => const DoctorsListScreen());
      case doctorDetails:
        final doctorId = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => DoctorDetailsScreen(doctorId: doctorId ?? ''));
      case doctorBooking:
        final doctorId = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => DoctorBookingScreen(doctorId: doctorId ?? ''));
      case patientDashboard:
        return MaterialPageRoute(builder: (_) => const PatientDashboard());
      case patientProfile:
        return MaterialPageRoute(builder: (_) => const PatientProfile());
      case patientMedicalHistory:
        return MaterialPageRoute(builder: (_) => const PatientMedicalHistory());
      case patientAppointments:
        return MaterialPageRoute(builder: (_) => const PatientAppointments());
      case patientPrescriptions:
        return MaterialPageRoute(builder: (_) => const PatientPrescriptions());
      case pharmaciesList:
        return MaterialPageRoute(builder: (_) => const PharmaciesListScreen());
      case pharmacyProducts:
        final pharmacyId = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => PharmacyProductsScreen(pharmacyId: pharmacyId ?? ''));
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case labsList:
        return MaterialPageRoute(builder: (_) => const LabsListScreen());
      case labTests:
        final labId = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => LabTestsScreen(labId: labId ?? ''));
      case testBooking:
        final testId = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => TestBookingScreen(testId: testId ?? ''));
      case insuranceCompanies:
        return MaterialPageRoute(builder: (_) => const InsuranceCompanies());
      case insurancePlans:
        final companyId = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => InsurancePlans(companyId: companyId ?? ''));
      case healthDashboard:
        return MaterialPageRoute(builder: (_) => const HealthDashboard());
      case wallet:
        return MaterialPageRoute(builder: (_) => const WalletScreen());
      case paymentMethods:
        return MaterialPageRoute(builder: (_) => const PaymentMethods());
      case emergencyNumbers:
        return MaterialPageRoute(builder: (_) => const EmergencyNumbers());
      case sos:
        return MaterialPageRoute(builder: (_) => const SosScreen());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case reports:
        return MaterialPageRoute(builder: (_) => const ReportsDashboard());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
