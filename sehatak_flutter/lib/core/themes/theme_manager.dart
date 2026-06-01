import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ThemeManager {
  // ========== الثيم النهاري ==========
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: const Color(0xFFF8FAFB),
    fontFamily: 'Cairo',
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: Colors.white,
      background: Color(0xFFF8FAFB),
      error: AppColors.error,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(color: Color(0xFF1A1A2E), fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Cairo'),
      iconTheme: IconThemeData(color: Color(0xFF1A1A2E)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 14),
        elevation: 2,
      ),
    ),
    cardTheme: CardTheme(elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), color: Colors.white),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Color(0xFF9E9E9E),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF1F5F9),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    ),
    dividerTheme: const DividerThemeData(color: Color(0xFFEEEEEE), thickness: 1),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
    chipTheme: ChipThemeData(backgroundColor: const Color(0xFFF1F5F9), selectedColor: AppColors.primary.withOpacity(0.15), labelStyle: const TextStyle(fontSize: 12)),
    tabBarTheme: const TabBarTheme(labelColor: AppColors.primary, unselectedLabelColor: Color(0xFF9E9E9E), indicatorColor: AppColors.primary),
  );

  // ========== الثيم الليلي - كحلي فاخر ==========
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF38BDF8), // أزرق سماوي
    scaffoldBackgroundColor: const Color(0xFF0B1121), // كحلي غامق جداً
    fontFamily: 'Cairo',
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF38BDF8),
      secondary: Color(0xFF818CF8),
      surface: Color(0xFF1A2540), // كحلي متوسط للبطاقات
      background: Color(0xFF0B1121),
      error: Color(0xFFF87171),
      onPrimary: Color(0xFF0B1121),
      onSecondary: Colors.white,
      onSurface: Color(0xFFE2E8F0),
    ),
    
    // ========== AppBar ==========
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF111D33),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(color: Color(0xFFF1F5F9), fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Cairo'),
      iconTheme: IconThemeData(color: Color(0xFFF1F5F9)),
    ),
    
    // ========== الأزرار ==========
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF38BDF8),
        foregroundColor: const Color(0xFF0B1121),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w600),
        elevation: 3,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF38BDF8),
        side: const BorderSide(color: Color(0xFF38BDF8)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    
    // ========== البطاقات ==========
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: const Color(0xFF1A2540), // كحلي للبطاقات
      shadowColor: Colors.black38,
    ),
    
    // ========== شريط التنقل السفلي ==========
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF111D33),
      selectedItemColor: Color(0xFF38BDF8),
      unselectedItemColor: Color(0xFF64748B),
      type: BottomNavigationBarType.fixed,
      elevation: 12,
    ),
    
    // ========== حقول الإدخال ==========
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1A2540), // كحلي للحقول
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2D3A54))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF38BDF8), width: 2)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      hintStyle: const TextStyle(color: Color(0xFF64748B)),
      labelStyle: const TextStyle(color: Color(0xFF94A3B8)),
    ),
    
    // ========== الفواصل ==========
    dividerTheme: const DividerThemeData(color: Color(0xFF2D3A54), thickness: 1),
    
    // ========== زر FAB ==========
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF38BDF8),
      foregroundColor: Color(0xFF0B1121),
    ),
    
    // ========== الشرائح ==========
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF1A2540),
      selectedColor: const Color(0xFF38BDF8).withOpacity(0.25),
      labelStyle: const TextStyle(fontSize: 12),
      side: const BorderSide(color: Color(0xFF2D3A54)),
    ),
    
    // ========== التبويبات ==========
    tabBarTheme: const TabBarTheme(
      labelColor: Color(0xFF38BDF8),
      unselectedLabelColor: Color(0xFF64748B),
      indicatorColor: Color(0xFF38BDF8),
    ),
    
    // ========== الحوارات ==========
    dialogTheme: DialogTheme(
      backgroundColor: const Color(0xFF1A2540),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: const TextStyle(color: Color(0xFFF1F5F9), fontSize: 18, fontWeight: FontWeight.bold),
    ),
    
    // ========== SnackBar ==========
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF1A2540),
      contentTextStyle: const TextStyle(color: Color(0xFFF1F5F9)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    
    // ========== المفاتيح ==========
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) => const Color(0xFF38BDF8)),
      trackColor: MaterialStateProperty.resolveWith((states) => const Color(0xFF2D3A54)),
    ),
    
    // ========== Checkbox ==========
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) => const Color(0xFF38BDF8)),
      checkColor: MaterialStateProperty.all(const Color(0xFF0B1121)),
    ),
    
    // ========== القوائم المنبثقة ==========
    popupMenuTheme: PopupMenuThemeData(
      color: const Color(0xFF1A2540),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    
    // ========== Bottom Sheet ==========
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1A2540),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    ),
    
    // ========== Slider ==========
    sliderTheme: SliderThemeData(
      activeTrackColor: const Color(0xFF38BDF8),
      inactiveTrackColor: const Color(0xFF2D3A54),
      thumbColor: const Color(0xFF38BDF8),
      overlayColor: const Color(0xFF38BDF8).withOpacity(0.2),
    ),
    
    // ========== Progress Indicator ==========
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0xFF38BDF8),
      linearTrackColor: Color(0xFF2D3A54),
    ),
  );
}
