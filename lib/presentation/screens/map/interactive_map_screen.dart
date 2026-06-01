import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class InteractiveMapScreen extends StatefulWidget {
  final String type;
  final String? orderId;
  const InteractiveMapScreen({super.key, this.type = 'hospitals', this.orderId});

  @override
  State<InteractiveMapScreen> createState() => _InteractiveMapScreenState();
}

class _InteractiveMapScreenState extends State<InteractiveMapScreen> {
  late final MapController _mapController;
  static const LatLng sanaaCenter = LatLng(15.3694, 44.1910);
  String _selectedLayer = 'خريطة ملونة';
  Position? _currentPosition;
  LatLng? _selectedLocation;
  int _currentStep = 2;

  final Map<String, Map<String, String>> _mapLayers = {
    'خريطة ملونة': {'url': 'https://a.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png', 'desc': 'خرائط ملونة مع أسماء'},
    'خريطة فاتحة': {'url': 'https://a.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', 'desc': 'خرائط فاتحة للتفاصيل'},
    'خريطة داكنة': {'url': 'https://a.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png', 'desc': 'خرائط داكنة للمساء'},
  };

  // ==================== 60 مستشفى في صنعاء ====================
  final List<Map<String, dynamic>> _hospitals = [
    {'name': 'مستشفى الثورة العام', 'address': 'شارع الزبيري، باب اليمن', 'lat': 15.3500, 'lng': 44.2000, 'phone': '01-222222', 'type': 'حكومي', 'beds': '500', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الكويت الجامعي', 'address': 'شارع الخمسين، الحصبة', 'lat': 15.3800, 'lng': 44.2100, 'phone': '01-333333', 'type': 'جامعي', 'beds': '400', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى السبعين للأمومة والطفولة', 'address': 'السبعين، شارع الأربعين', 'lat': 15.3100, 'lng': 44.1800, 'phone': '01-444444', 'type': 'تخصصي', 'beds': '300', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى آزال', 'address': 'شارع هائل، التحرير', 'lat': 15.3600, 'lng': 44.1950, 'phone': '01-555555', 'type': 'خاص', 'beds': '150', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى جامعة العلوم والتكنولوجيا', 'address': 'شارع الستين، شارع الستين الشمالي', 'lat': 15.3400, 'lng': 44.1700, 'phone': '01-666666', 'type': 'جامعي', 'beds': '250', 'emergency': true, 'image': '🏥'},
    {'name': 'المستشفى العسكري', 'address': 'شارع القاهرة، التحرير', 'lat': 15.3550, 'lng': 44.2050, 'phone': '01-777777', 'type': 'عسكري', 'beds': '600', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى النقيب', 'address': 'شارع العدين، شارع الستين', 'lat': 15.3300, 'lng': 44.1850, 'phone': '01-888888', 'type': 'خاص', 'beds': '100', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى العلوم الحديثة', 'address': 'شارع الخمسين، تقاطع هائل', 'lat': 15.3750, 'lng': 44.2000, 'phone': '01-999999', 'type': 'خاص', 'beds': '120', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى اليمن الألماني', 'address': 'شارع الستين، أمام الخطوط الجوية', 'lat': 15.3450, 'lng': 44.1750, 'phone': '01-111222', 'type': 'خاص', 'beds': '200', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الأمل', 'address': 'شارع الزبيري، بجانب البنك المركزي', 'lat': 15.3490, 'lng': 44.2020, 'phone': '01-222333', 'type': 'خاص', 'beds': '80', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الحياة', 'address': 'شارع هائل، جولة كنتاكي', 'lat': 15.3630, 'lng': 44.1940, 'phone': '01-333444', 'type': 'خاص', 'beds': '90', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الصفوة', 'address': 'شارع التحرير، عمارة الكبوس', 'lat': 15.3580, 'lng': 44.1930, 'phone': '01-444555', 'type': 'خاص', 'beds': '110', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى الخليج', 'address': 'شارع الستين، مجمع النخبة', 'lat': 15.3350, 'lng': 44.1820, 'phone': '01-555666', 'type': 'خاص', 'beds': '130', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى ابن النفيس', 'address': 'شارع باب اليمن، وسط المدينة', 'lat': 15.3470, 'lng': 44.2030, 'phone': '01-666777', 'type': 'خاص', 'beds': '70', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى الرازي', 'address': 'شارع الخمسين، حي الأندلس', 'lat': 15.3720, 'lng': 44.2020, 'phone': '01-777888', 'type': 'خاص', 'beds': '160', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الأهلي', 'address': 'شارع القاهرة، بجانب السفارة', 'lat': 15.3520, 'lng': 44.2040, 'phone': '01-888999', 'type': 'خاص', 'beds': '140', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى فلسطين', 'address': 'شارع الستين، شارع تعز', 'lat': 15.3200, 'lng': 44.1790, 'phone': '01-999000', 'type': 'خاص', 'beds': '100', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى 22 مايو', 'address': 'شارع الأربعين، شارع صخر', 'lat': 15.3150, 'lng': 44.1770, 'phone': '01-000111', 'type': 'حكومي', 'beds': '220', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى 48', 'address': 'شارع الستين، بجانب جولة 48', 'lat': 15.3380, 'lng': 44.1880, 'phone': '01-111333', 'type': 'حكومي', 'beds': '180', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى جامعة الإيمان', 'address': 'شارع العدين، طريق عمران', 'lat': 15.3800, 'lng': 44.2150, 'phone': '01-222444', 'type': 'جامعي', 'beds': '300', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الفارابي', 'address': 'شارع هائل، حي الروضة', 'lat': 15.3680, 'lng': 44.1920, 'phone': '01-333555', 'type': 'خاص', 'beds': '85', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى الحكمة', 'address': 'شارع الزبيري، عمارة النجار', 'lat': 15.3460, 'lng': 44.1990, 'phone': '01-444666', 'type': 'خاص', 'beds': '95', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى السلام', 'address': 'شارع التحرير، وسط البلد', 'lat': 15.3560, 'lng': 44.1960, 'phone': '01-555777', 'type': 'خاص', 'beds': '75', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى القدس', 'address': 'شارع الستين، جولة المصباحي', 'lat': 15.3260, 'lng': 44.1810, 'phone': '01-666888', 'type': 'خاص', 'beds': '105', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى ابن سينا', 'address': 'شارع الخمسين، دار الرئاسة', 'lat': 15.3700, 'lng': 44.2040, 'phone': '01-777999', 'type': 'خاص', 'beds': '190', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الأقصى', 'address': 'شارع باب اليمن، سوق الملح', 'lat': 15.3440, 'lng': 44.2010, 'phone': '01-888000', 'type': 'خاص', 'beds': '60', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى النور', 'address': 'شارع القاهرة، حي السياسي', 'lat': 15.3530, 'lng': 44.2070, 'phone': '01-999111', 'type': 'خاص', 'beds': '115', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الهدى', 'address': 'شارع الستين، الحديدة', 'lat': 15.3400, 'lng': 44.1740, 'phone': '01-000222', 'type': 'خاص', 'beds': '88', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى الفيحاء', 'address': 'شارع العدين، السنينة', 'lat': 15.3900, 'lng': 44.2120, 'phone': '01-111444', 'type': 'خاص', 'beds': '125', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الرحمة', 'address': 'شارع هائل، شارع الأربعين', 'lat': 15.3640, 'lng': 44.1980, 'phone': '01-222555', 'type': 'خاص', 'beds': '72', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى طيبة', 'address': 'شارع الزبيري، باب شعوب', 'lat': 15.3550, 'lng': 44.1970, 'phone': '01-333666', 'type': 'خاص', 'beds': '135', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الجزيرة', 'address': 'شارع التحرير، بجانب البريد', 'lat': 15.3610, 'lng': 44.1910, 'phone': '01-444777', 'type': 'خاص', 'beds': '80', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى الهلال', 'address': 'شارع الستين، مجمع الصمد', 'lat': 15.3320, 'lng': 44.1830, 'phone': '01-555888', 'type': 'خاص', 'beds': '98', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الزهراء', 'address': 'شارع الخمسين، مدينة النور', 'lat': 15.3770, 'lng': 44.2060, 'phone': '01-666999', 'type': 'خاص', 'beds': '145', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الأندلس', 'address': 'شارع باب اليمن، شارع صالح', 'lat': 15.3430, 'lng': 44.2000, 'phone': '01-777000', 'type': 'خاص', 'beds': '68', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى التعاون', 'address': 'شارع القاهرة، بجانب المجلس', 'lat': 15.3580, 'lng': 44.2080, 'phone': '01-888111', 'type': 'حكومي', 'beds': '280', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الإخلاص', 'address': 'شارع الستين، تقاطع تعز', 'lat': 15.3180, 'lng': 44.1760, 'phone': '01-999222', 'type': 'خاص', 'beds': '55', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى الوفاء', 'address': 'شارع هائل، أمام المطار', 'lat': 15.3730, 'lng': 44.1900, 'phone': '01-000333', 'type': 'خاص', 'beds': '108', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الصادق', 'address': 'شارع الزبيري، شارع السائلة', 'lat': 15.3480, 'lng': 44.1960, 'phone': '01-111555', 'type': 'خاص', 'beds': '92', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى اليمامة', 'address': 'شارع العدين، طريق صنعاء', 'lat': 15.3850, 'lng': 44.2130, 'phone': '01-222666', 'type': 'خاص', 'beds': '118', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى البراء', 'address': 'شارع التحرير، عمارة الحمدي', 'lat': 15.3540, 'lng': 44.1940, 'phone': '01-333777', 'type': 'خاص', 'beds': '65', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى الإسراء', 'address': 'شارع الستين، شارع العدين', 'lat': 15.3340, 'lng': 44.1840, 'phone': '01-444888', 'type': 'خاص', 'beds': '132', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى العباس', 'address': 'شارع الخمسين، بجانب الخطوط', 'lat': 15.3760, 'lng': 44.2030, 'phone': '01-555999', 'type': 'خاص', 'beds': '78', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى الزيتون', 'address': 'شارع باب اليمن، سوق الحلقة', 'lat': 15.3420, 'lng': 44.1980, 'phone': '01-666000', 'type': 'خاص', 'beds': '85', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى دار الشفاء', 'address': 'شارع القاهرة، حي الحشيشي', 'lat': 15.3570, 'lng': 44.2060, 'phone': '01-777111', 'type': 'خاص', 'beds': '155', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى البشير', 'address': 'شارع الستين، جولة 48', 'lat': 15.3370, 'lng': 44.1890, 'phone': '01-888222', 'type': 'خاص', 'beds': '102', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى القاسمي', 'address': 'شارع هائل، نهاية الخط', 'lat': 15.3660, 'lng': 44.1930, 'phone': '01-999333', 'type': 'خاص', 'beds': '175', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الفردوس', 'address': 'شارع الزبيري، عمارة النجم', 'lat': 15.3510, 'lng': 44.1950, 'phone': '01-000444', 'type': 'خاص', 'beds': '58', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى 7 يوليو', 'address': 'شارع العدين، السنينة الشمالية', 'lat': 15.3920, 'lng': 44.2160, 'phone': '01-111666', 'type': 'حكومي', 'beds': '350', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الوحدة', 'address': 'شارع الخمسين، حي المطار', 'lat': 15.3740, 'lng': 44.2080, 'phone': '01-222777', 'type': 'خاص', 'beds': '112', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الأقصى الجديد', 'address': 'شارع التحرير، أمام البنك', 'lat': 15.3590, 'lng': 44.1950, 'phone': '01-333888', 'type': 'خاص', 'beds': '95', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى النهضة', 'address': 'شارع الستين، شارع مأرب', 'lat': 15.3280, 'lng': 44.1800, 'phone': '01-444999', 'type': 'خاص', 'beds': '148', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الإسراء التخصصي', 'address': 'شارع باب اليمن، بجانب الجامع', 'lat': 15.3450, 'lng': 44.1970, 'phone': '01-555000', 'type': 'خاص', 'beds': '168', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى السلامة', 'address': 'شارع القاهرة، بجانب سوق القات', 'lat': 15.3500, 'lng': 44.2030, 'phone': '01-666111', 'type': 'خاص', 'beds': '62', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى العروبة', 'address': 'شارع الستين، طريق الحديدة', 'lat': 15.3160, 'lng': 44.1750, 'phone': '01-777222', 'type': 'خاص', 'beds': '138', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى جيبلا', 'address': 'شارع هائل، فرع الجامعة', 'lat': 15.3690, 'lng': 44.1970, 'phone': '01-888333', 'type': 'خاص', 'beds': '88', 'emergency': false, 'image': '🏥'},
    {'name': 'المستشفى الجمهوري', 'address': 'شارع الزبيري، ميدان التحرير', 'lat': 15.3530, 'lng': 44.2010, 'phone': '01-999444', 'type': 'حكومي', 'beds': '450', 'emergency': true, 'image': '🏥'},
    {'name': 'مستشفى الأطباء', 'address': 'شارع الخمسين، خلف الجامعة', 'lat': 15.3780, 'lng': 44.2050, 'phone': '01-000555', 'type': 'خاص', 'beds': '125', 'emergency': false, 'image': '🏥'},
    {'name': 'مستشفى اليمن الدولي', 'address': 'شارع الستين، جولة آية', 'lat': 15.3410, 'lng': 44.1720, 'phone': '01-111777', 'type': 'خاص', 'beds': '210', 'emergency': true, 'image': '🏥'},
  ];

  // ==================== 60 صيدلية ====================
  final List<Map<String, dynamic>> _pharmacies = [
    {'name': 'صيدلية الشفاء', 'address': 'شارع الزبيري، أمام مستشفى الثورة', 'lat': 15.3510, 'lng': 44.1990, 'phone': '01-123456', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية اليمن', 'address': 'شارع التحرير، بجانب البنك المركزي', 'lat': 15.3580, 'lng': 44.1930, 'phone': '01-234567', 'hours': '8 ص - 12 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الأمل', 'address': 'شارع هائل، أمام جامعة صنعاء', 'lat': 15.3650, 'lng': 44.1970, 'phone': '01-345678', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية ابن حيان', 'address': 'شارع الستين، الحصبة', 'lat': 15.3820, 'lng': 44.2080, 'phone': '01-456789', 'hours': '8 ص - 11 م', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية الشهيد', 'address': 'شارع القاهرة، باب اليمن', 'lat': 15.3480, 'lng': 44.2020, 'phone': '01-567890', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية النصر', 'address': 'شارع الأربعين، شارع الستين', 'lat': 15.3250, 'lng': 44.1830, 'phone': '01-678901', 'hours': '9 ص - 10 م', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية الحياة', 'address': 'شارع الزبيري، عمارة النعمان', 'lat': 15.3520, 'lng': 44.1980, 'phone': '01-789012', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية البرج', 'address': 'شارع هائل، جولة كنتاكي', 'lat': 15.3620, 'lng': 44.1960, 'phone': '01-890123', 'hours': '8 ص - 12 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية اليقين', 'address': 'شارع التحرير، عمارة البساطي', 'lat': 15.3570, 'lng': 44.1940, 'phone': '01-901234', 'hours': '24 ساعة', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية الوطنية', 'address': 'شارع الستين، أمام المستشفى العسكري', 'lat': 15.3540, 'lng': 44.2030, 'phone': '01-012345', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الصحة', 'address': 'شارع الخمسين، الحصبة', 'lat': 15.3780, 'lng': 44.2070, 'phone': '01-112233', 'hours': '9 ص - 10 م', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية الإيمان', 'address': 'شارع باب اليمن، سوق الملح', 'lat': 15.3430, 'lng': 44.2000, 'phone': '01-223344', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الرازي', 'address': 'شارع القاهرة، حي السياسي', 'lat': 15.3550, 'lng': 44.2060, 'phone': '01-334455', 'hours': '8 ص - 11 م', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية القدس', 'address': 'شارع العدين، السنينة', 'lat': 15.3860, 'lng': 44.2110, 'phone': '01-445566', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الأقصى', 'address': 'شارع الأربعين، شارع صخر', 'lat': 15.3140, 'lng': 44.1780, 'phone': '01-556677', 'hours': '8 ص - 10 م', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية النور', 'address': 'شارع الزبيري، بجانب برج زبيدة', 'lat': 15.3490, 'lng': 44.1960, 'phone': '01-667788', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الهدى', 'address': 'شارع الستين، شارع تعز', 'lat': 15.3190, 'lng': 44.1790, 'phone': '01-778899', 'hours': '9 ص - 12 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الفاروق', 'address': 'شارع هائل، حي الروضة', 'lat': 15.3670, 'lng': 44.1920, 'phone': '01-889900', 'hours': '24 ساعة', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية السلام', 'address': 'شارع التحرير، وسط البلد', 'lat': 15.3560, 'lng': 44.1950, 'phone': '01-990011', 'hours': '8 ص - 11 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الوفاء', 'address': 'شارع الخمسين، دار الرئاسة', 'lat': 15.3710, 'lng': 44.2040, 'phone': '01-001122', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الأندلس', 'address': 'شارع باب اليمن، شارع صالح', 'lat': 15.3440, 'lng': 44.1990, 'phone': '01-112244', 'hours': '8 ص - 10 م', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية الحكمة', 'address': 'شارع الستين، جولة المصباحي', 'lat': 15.3270, 'lng': 44.1810, 'phone': '01-223355', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الأطباء', 'address': 'شارع القاهرة، بجانب السفارة', 'lat': 15.3520, 'lng': 44.2050, 'phone': '01-334466', 'hours': '9 ص - 11 م', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية المستقبل', 'address': 'شارع الزبيري، شارع السائلة', 'lat': 15.3470, 'lng': 44.1950, 'phone': '01-445577', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية التعاون', 'address': 'شارع هائل، شارع الأربعين', 'lat': 15.3630, 'lng': 44.1980, 'phone': '01-556688', 'hours': '8 ص - 12 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية المدينة', 'address': 'شارع الستين، مجمع النخبة', 'lat': 15.3330, 'lng': 44.1820, 'phone': '01-667799', 'hours': '24 ساعة', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية اليمامة', 'address': 'شارع التحرير، عمارة الحمدي', 'lat': 15.3540, 'lng': 44.1920, 'phone': '01-778800', 'hours': '9 ص - 10 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الربيع', 'address': 'شارع العدين، طريق عمران', 'lat': 15.3880, 'lng': 44.2140, 'phone': '01-889911', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الجزيرة', 'address': 'شارع الخمسين، بجانب الخطوط', 'lat': 15.3730, 'lng': 44.2060, 'phone': '01-990022', 'hours': '8 ص - 11 م', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية الأقصى الجديدة', 'address': 'شارع باب اليمن، سوق الحلقة', 'lat': 15.3410, 'lng': 44.1980, 'phone': '01-001133', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الهلال', 'address': 'شارع الستين، شارع مأرب', 'lat': 15.3290, 'lng': 44.1780, 'phone': '01-112255', 'hours': '8 ص - 10 م', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية الزهراء', 'address': 'شارع القاهرة، حي الحشيشي', 'lat': 15.3560, 'lng': 44.2070, 'phone': '01-223366', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الأمن', 'address': 'شارع الزبيري، عمارة النجم', 'lat': 15.3500, 'lng': 44.1940, 'phone': '01-334477', 'hours': '9 ص - 12 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الإخلاص', 'address': 'شارع هائل، نهاية الخط', 'lat': 15.3660, 'lng': 44.1930, 'phone': '01-445588', 'hours': '24 ساعة', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية طيبة', 'address': 'شارع التحرير، أمام البنك', 'lat': 15.3590, 'lng': 44.1960, 'phone': '01-556699', 'hours': '8 ص - 11 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الصفوة', 'address': 'شارع الستين، تقاطع تعز', 'lat': 15.3170, 'lng': 44.1760, 'phone': '01-667700', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية النهضة', 'address': 'شارع الخمسين، مدينة النور', 'lat': 15.3760, 'lng': 44.2050, 'phone': '01-778811', 'hours': '9 ص - 10 م', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية الفيحاء', 'address': 'شارع باب اليمن، بجانب الجامع', 'lat': 15.3450, 'lng': 44.1970, 'phone': '01-889922', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الرحمة', 'address': 'شارع العدين، طريق صنعاء', 'lat': 15.3840, 'lng': 44.2120, 'phone': '01-990033', 'hours': '8 ص - 12 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية البراء', 'address': 'شارع القاهرة، بجانب المجلس', 'lat': 15.3570, 'lng': 44.2080, 'phone': '01-001144', 'hours': '24 ساعة', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية العروبة', 'address': 'شارع الستين، طريق الحديدة', 'lat': 15.3150, 'lng': 44.1740, 'phone': '01-112266', 'hours': '9 ص - 11 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الفردوس', 'address': 'شارع الزبيري، باب شعوب', 'lat': 15.3540, 'lng': 44.1970, 'phone': '01-223377', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية العنقاء', 'address': 'شارع هائل، فرع الجامعة', 'lat': 15.3680, 'lng': 44.1940, 'phone': '01-334488', 'hours': '8 ص - 10 م', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية البشير', 'address': 'شارع التحرير، عمارة الكبوس', 'lat': 15.3600, 'lng': 44.1910, 'phone': '01-445599', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية النجاح', 'address': 'شارع الستين، مجمع الصمد', 'lat': 15.3310, 'lng': 44.1840, 'phone': '01-556600', 'hours': '9 ص - 12 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية اليمن السعيد', 'address': 'شارع الخمسين، حي المطار', 'lat': 15.3750, 'lng': 44.2090, 'phone': '01-667711', 'hours': '24 ساعة', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية دار الدواء', 'address': 'شارع باب اليمن، شارع صالح', 'lat': 15.3420, 'lng': 44.1990, 'phone': '01-778822', 'hours': '8 ص - 11 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية اليسر', 'address': 'شارع القاهرة، بجانب سوق القات', 'lat': 15.3510, 'lng': 44.2040, 'phone': '01-889933', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الريان', 'address': 'شارع الستين، شارع العدين', 'lat': 15.3350, 'lng': 44.1860, 'phone': '01-990044', 'hours': '9 ص - 10 م', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية الإحسان', 'address': 'شارع الزبيري، عمارة النجار', 'lat': 15.3460, 'lng': 44.1980, 'phone': '01-001155', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية السعادة', 'address': 'شارع هائل، أمام المطار', 'lat': 15.3720, 'lng': 44.1890, 'phone': '01-112277', 'hours': '8 ص - 12 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية التوفيق', 'address': 'شارع التحرير، بجانب البريد', 'lat': 15.3610, 'lng': 44.1920, 'phone': '01-223388', 'hours': '24 ساعة', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية الخير', 'address': 'شارع العدين، السنينة الشمالية', 'lat': 15.3910, 'lng': 44.2150, 'phone': '01-334499', 'hours': '9 ص - 11 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الأنوار', 'address': 'شارع الستين، جولة 48', 'lat': 15.3360, 'lng': 44.1870, 'phone': '01-445500', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية الجامعة', 'address': 'شارع الخمسين، خلف الجامعة', 'lat': 15.3790, 'lng': 44.2040, 'phone': '01-556611', 'hours': '8 ص - 10 م', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية الهداية', 'address': 'شارع باب اليمن، ميدان التحرير', 'lat': 15.3480, 'lng': 44.2010, 'phone': '01-667722', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية المنار', 'address': 'شارع القاهرة، حي السياسي', 'lat': 15.3540, 'lng': 44.2040, 'phone': '01-778833', 'hours': '9 ص - 12 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية التقوى', 'address': 'شارع الستين، شارع الستين الشمالي', 'lat': 15.3390, 'lng': 44.1710, 'phone': '01-889944', 'hours': '24 ساعة', 'image': '💊', 'delivery': false},
    {'name': 'صيدلية الروضة', 'address': 'شارع هائل، جولة كنتاكي', 'lat': 15.3640, 'lng': 44.1960, 'phone': '01-990055', 'hours': '8 ص - 11 م', 'image': '💊', 'delivery': true},
    {'name': 'صيدلية البستان', 'address': 'شارع الزبيري، أمام الخطوط الجوية', 'lat': 15.3470, 'lng': 44.2000, 'phone': '01-001166', 'hours': '24 ساعة', 'image': '💊', 'delivery': true},
  ];

// ==================== 60 مختبر ومعمل ====================
  final List<Map<String, dynamic>> _labs = [
    {'name': 'المختبر الوطني', 'address': 'شارع الستين، أمام المستشفى العسكري', 'lat': 15.3540, 'lng': 44.2030, 'phone': '01-012345', 'tests': '650+', 'image': '🔬', 'accredited': true, 'homeService': true},
    {'name': 'مختبر الثقة', 'address': 'شارع الزبيري، عمارة النعمان', 'lat': 15.3520, 'lng': 44.1980, 'phone': '01-123456', 'tests': '520+', 'image': '🔬', 'accredited': true, 'homeService': true},
    {'name': 'مختبر البرج', 'address': 'شارع هائل، جولة كنتاكي', 'lat': 15.3620, 'lng': 44.1960, 'phone': '01-234567', 'tests': '480+', 'image': '🔬', 'accredited': true, 'homeService': false},
    {'name': 'مختبر اليقين', 'address': 'شارع التحرير، عمارة البساطي', 'lat': 15.3570, 'lng': 44.1940, 'phone': '01-345678', 'tests': '350+', 'image': '🔬', 'accredited': true, 'homeService': true},
    {'name': 'مختبرات الحياة', 'address': 'شارع الخمسين، الحصبة', 'lat': 15.3780, 'lng': 44.2070, 'phone': '01-456789', 'tests': '420+', 'image': '🔬', 'accredited': false, 'homeService': true},
    {'name': 'معمل ابن سينا', 'address': 'شارع الزبيري، بجانب برج زبيدة', 'lat': 15.3490, 'lng': 44.1960, 'phone': '01-567890', 'tests': '380+', 'image': '🧪', 'accredited': true, 'homeService': false},
    {'name': 'مختبر الأمل', 'address': 'شارع هائل، أمام جامعة صنعاء', 'lat': 15.3650, 'lng': 44.1970, 'phone': '01-678901', 'tests': '290+', 'image': '🔬', 'accredited': false, 'homeService': true},
    {'name': 'معامل النخبة', 'address': 'شارع الستين، مجمع النخبة', 'lat': 15.3330, 'lng': 44.1820, 'phone': '01-789012', 'tests': '550+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر الشروق', 'address': 'شارع القاهرة، باب اليمن', 'lat': 15.3480, 'lng': 44.2020, 'phone': '01-890123', 'tests': '310+', 'image': '🔬', 'accredited': false, 'homeService': false},
    {'name': 'معمل الدقة', 'address': 'شارع العدين، السنينة', 'lat': 15.3860, 'lng': 44.2110, 'phone': '01-901234', 'tests': '460+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر الصحة', 'address': 'شارع الأربعين، شارع صخر', 'lat': 15.3140, 'lng': 44.1780, 'phone': '01-112345', 'tests': '270+', 'image': '🔬', 'accredited': false, 'homeService': true},
    {'name': 'معامل اليمن', 'address': 'شارع التحرير، عمارة الحمدي', 'lat': 15.3540, 'lng': 44.1920, 'phone': '01-223456', 'tests': '500+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر القدس', 'address': 'شارع الخمسين، دار الرئاسة', 'lat': 15.3710, 'lng': 44.2040, 'phone': '01-334567', 'tests': '340+', 'image': '🔬', 'accredited': true, 'homeService': false},
    {'name': 'معمل الرازي', 'address': 'شارع باب اليمن، سوق الملح', 'lat': 15.3430, 'lng': 44.2000, 'phone': '01-445678', 'tests': '410+', 'image': '🧪', 'accredited': false, 'homeService': true},
    {'name': 'مختبر الإيمان', 'address': 'شارع القاهرة، حي السياسي', 'lat': 15.3550, 'lng': 44.2060, 'phone': '01-556789', 'tests': '280+', 'image': '🔬', 'accredited': true, 'homeService': true},
    {'name': 'معامل الصفوة', 'address': 'شارع الستين، شارع تعز', 'lat': 15.3190, 'lng': 44.1790, 'phone': '01-667890', 'tests': '530+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر الجزيرة', 'address': 'شارع الزبيري، شارع السائلة', 'lat': 15.3470, 'lng': 44.1950, 'phone': '01-778901', 'tests': '360+', 'image': '🔬', 'accredited': false, 'homeService': false},
    {'name': 'معمل السلام', 'address': 'شارع هائل، حي الروضة', 'lat': 15.3670, 'lng': 44.1920, 'phone': '01-889012', 'tests': '440+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر الهدى', 'address': 'شارع الستين، جولة المصباحي', 'lat': 15.3270, 'lng': 44.1810, 'phone': '01-990123', 'tests': '250+', 'image': '🔬', 'accredited': false, 'homeService': true},
    {'name': 'معامل الفارابي', 'address': 'شارع التحرير، وسط البلد', 'lat': 15.3560, 'lng': 44.1950, 'phone': '01-001234', 'tests': '580+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر الأندلس', 'address': 'شارع العدين، طريق عمران', 'lat': 15.3880, 'lng': 44.2140, 'phone': '01-112456', 'tests': '320+', 'image': '🔬', 'accredited': true, 'homeService': false},
    {'name': 'معمل الحكمة', 'address': 'شارع الخمسين، بجانب الخطوط', 'lat': 15.3730, 'lng': 44.2060, 'phone': '01-223567', 'tests': '470+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر النور', 'address': 'شارع باب اليمن، شارع صالح', 'lat': 15.3440, 'lng': 44.1990, 'phone': '01-334678', 'tests': '390+', 'image': '🔬', 'accredited': false, 'homeService': true},
    {'name': 'معامل الأطباء', 'address': 'شارع القاهرة، بجانب السفارة', 'lat': 15.3520, 'lng': 44.2050, 'phone': '01-445789', 'tests': '510+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر اليمامة', 'address': 'شارع الستين، شارع مأرب', 'lat': 15.3290, 'lng': 44.1780, 'phone': '01-556890', 'tests': '260+', 'image': '🔬', 'accredited': false, 'homeService': false},
    {'name': 'معمل التعاون', 'address': 'شارع الزبيري، عمارة النجم', 'lat': 15.3500, 'lng': 44.1940, 'phone': '01-667901', 'tests': '430+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر المستقبل', 'address': 'شارع هائل، شارع الأربعين', 'lat': 15.3630, 'lng': 44.1980, 'phone': '01-778012', 'tests': '370+', 'image': '🔬', 'accredited': true, 'homeService': true},
    {'name': 'معامل الزهراء', 'address': 'شارع التحرير، أمام البنك', 'lat': 15.3590, 'lng': 44.1960, 'phone': '01-889123', 'tests': '490+', 'image': '🧪', 'accredited': true, 'homeService': false},
    {'name': 'مختبر الوفاء', 'address': 'شارع الستين، مجمع الصمد', 'lat': 15.3310, 'lng': 44.1840, 'phone': '01-990234', 'tests': '300+', 'image': '🔬', 'accredited': false, 'homeService': true},
    {'name': 'معمل الفيحاء', 'address': 'شارع الخمسين، مدينة النور', 'lat': 15.3760, 'lng': 44.2050, 'phone': '01-001345', 'tests': '540+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر الهلال', 'address': 'شارع باب اليمن، بجانب الجامع', 'lat': 15.3450, 'lng': 44.1970, 'phone': '01-112567', 'tests': '330+', 'image': '🔬', 'accredited': true, 'homeService': false},
    {'name': 'معامل الإخلاص', 'address': 'شارع القاهرة، حي الحشيشي', 'lat': 15.3560, 'lng': 44.2070, 'phone': '01-223678', 'tests': '450+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر طيبة', 'address': 'شارع العدين، طريق صنعاء', 'lat': 15.3840, 'lng': 44.2120, 'phone': '01-334789', 'tests': '280+', 'image': '🔬', 'accredited': false, 'homeService': true},
    {'name': 'معمل النهضة', 'address': 'شارع الزبيري، باب شعوب', 'lat': 15.3540, 'lng': 44.1970, 'phone': '01-445890', 'tests': '560+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر الربيع', 'address': 'شارع هائل، نهاية الخط', 'lat': 15.3660, 'lng': 44.1930, 'phone': '01-556901', 'tests': '240+', 'image': '🔬', 'accredited': false, 'homeService': false},
    {'name': 'معامل البراء', 'address': 'شارع الستين، تقاطع تعز', 'lat': 15.3170, 'lng': 44.1760, 'phone': '01-667012', 'tests': '480+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر العروبة', 'address': 'شارع التحرير، عمارة الكبوس', 'lat': 15.3600, 'lng': 44.1910, 'phone': '01-778123', 'tests': '310+', 'image': '🔬', 'accredited': true, 'homeService': true},
    {'name': 'معامل اليمن السعيد', 'address': 'شارع الستين، شارع العدين', 'lat': 15.3350, 'lng': 44.1860, 'phone': '01-889234', 'tests': '420+', 'image': '🧪', 'accredited': true, 'homeService': false},
    {'name': 'مختبر الإحسان', 'address': 'شارع الخمسين، حي المطار', 'lat': 15.3750, 'lng': 44.2090, 'phone': '01-990345', 'tests': '350+', 'image': '🔬', 'accredited': false, 'homeService': true},
    {'name': 'معمل الروضة', 'address': 'شارع باب اليمن، سوق الحلقة', 'lat': 15.3410, 'lng': 44.1980, 'phone': '01-001456', 'tests': '500+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر التوفيق', 'address': 'شارع القاهرة، بجانب المجلس', 'lat': 15.3570, 'lng': 44.2080, 'phone': '01-112678', 'tests': '270+', 'image': '🔬', 'accredited': false, 'homeService': true},
    {'name': 'معامل الخير', 'address': 'شارع الستين، طريق الحديدة', 'lat': 15.3150, 'lng': 44.1740, 'phone': '01-223789', 'tests': '460+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر الأنوار', 'address': 'شارع الزبيري، عمارة النجار', 'lat': 15.3460, 'lng': 44.1980, 'phone': '01-334890', 'tests': '380+', 'image': '🔬', 'accredited': true, 'homeService': false},
    {'name': 'معامل الهداية', 'address': 'شارع هائل، أمام المطار', 'lat': 15.3720, 'lng': 44.1890, 'phone': '01-445901', 'tests': '520+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر المنار', 'address': 'شارع العدين، السنينة الشمالية', 'lat': 15.3910, 'lng': 44.2150, 'phone': '01-556012', 'tests': '290+', 'image': '🔬', 'accredited': false, 'homeService': true},
    {'name': 'معامل التقوى', 'address': 'شارع الخمسين، خلف الجامعة', 'lat': 15.3790, 'lng': 44.2040, 'phone': '01-667123', 'tests': '440+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر البستان', 'address': 'شارع الستين، جولة 48', 'lat': 15.3360, 'lng': 44.1870, 'phone': '01-778234', 'tests': '360+', 'image': '🔬', 'accredited': true, 'homeService': false},
    {'name': 'معامل النجاح', 'address': 'شارع باب اليمن، ميدان التحرير', 'lat': 15.3480, 'lng': 44.2010, 'phone': '01-889345', 'tests': '500+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر اليسر', 'address': 'شارع القاهرة، حي السياسي', 'lat': 15.3540, 'lng': 44.2040, 'phone': '01-990456', 'tests': '330+', 'image': '🔬', 'accredited': false, 'homeService': true},
    {'name': 'معامل السعادة', 'address': 'شارع التحرير، بجانب البريد', 'lat': 15.3610, 'lng': 44.1920, 'phone': '01-001567', 'tests': '470+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر الريان', 'address': 'شارع الستين، شارع الستين الشمالي', 'lat': 15.3390, 'lng': 44.1710, 'phone': '01-112789', 'tests': '250+', 'image': '🔬', 'accredited': false, 'homeService': false},
    {'name': 'معامل دار الشفاء', 'address': 'شارع الزبيري، أمام الخطوط الجوية', 'lat': 15.3470, 'lng': 44.2000, 'phone': '01-223890', 'tests': '550+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر الأمن', 'address': 'شارع هائل، جولة كنتاكي', 'lat': 15.3640, 'lng': 44.1960, 'phone': '01-334901', 'tests': '390+', 'image': '🔬', 'accredited': true, 'homeService': true},
    {'name': 'معامل الصادق', 'address': 'شارع الخمسين، شارع الستين', 'lat': 15.3380, 'lng': 44.1880, 'phone': '01-445012', 'tests': '410+', 'image': '🧪', 'accredited': true, 'homeService': false},
    {'name': 'مختبر الفاروق', 'address': 'شارع باب اليمن، شارع باب اليمن', 'lat': 15.3500, 'lng': 44.1990, 'phone': '01-556123', 'tests': '300+', 'image': '🔬', 'accredited': false, 'homeService': true},
    {'name': 'معامل العنقاء', 'address': 'شارع الستين، جولة آية', 'lat': 15.3400, 'lng': 44.1730, 'phone': '01-667234', 'tests': '480+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر القاسمي', 'address': 'شارع التحرير، عمارة البساطي', 'lat': 15.3580, 'lng': 44.1930, 'phone': '01-778345', 'tests': '340+', 'image': '🔬', 'accredited': true, 'homeService': true},
    {'name': 'معامل الفتح', 'address': 'شارع الزبيري، شارع الستين', 'lat': 15.3320, 'lng': 44.1800, 'phone': '01-889456', 'tests': '420+', 'image': '🧪', 'accredited': true, 'homeService': true},
    {'name': 'مختبر النصر', 'address': 'شارع هائل، فرع الجامعة', 'lat': 15.3690, 'lng': 44.1950, 'phone': '01-990567', 'tests': '370+', 'image': '🔬', 'accredited': false, 'homeService': false},
  ];

List<Map<String, dynamic>> get _currentLocations {
    switch (widget.type) {
      case 'hospitals': return _hospitals;
      case 'pharmacies': return _pharmacies;
      case 'labs': return _labs;
      case 'tracking': return _hospitals;
      default: return _hospitals;
    }
  }

  String get _title {
    switch (widget.type) {
      case 'hospitals': return 'المستشفيات (${_hospitals.length})';
      case 'pharmacies': return 'الصيدليات (${_pharmacies.length})';
      case 'labs': return 'المختبرات (${_labs.length})';
      case 'tracking': return 'تتبع الطلب';
      default: return 'الخريطة';
    }
  }

  IconData get _icon {
    switch (widget.type) {
      case 'hospitals': return Icons.local_hospital;
      case 'pharmacies': return Icons.local_pharmacy;
      case 'labs': return Icons.science;
      case 'tracking': return Icons.local_shipping;
      default: return Icons.map;
    }
  }

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        final position = await Geolocator.getCurrentPosition();
        setState(() => _currentPosition = position);
      }
    } catch (_) {}
  }

  void _goToLocation(double lat, double lng) {
    _mapController.move(LatLng(lat, lng), 15);
    setState(() => _selectedLocation = LatLng(lat, lng));
  }

  Color _getMarkerColor() {
    switch (widget.type) {
      case 'hospitals': return AppColors.error;
      case 'pharmacies': return AppColors.success;
      case 'labs': return AppColors.info;
      case 'tracking': return AppColors.primary;
      default: return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final layerKey = isDark ? 'خريطة داكنة' : _selectedLayer;
    final layerUrl = _mapLayers[layerKey]!['url']!;

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          if (widget.type != 'tracking')
            PopupMenuButton<String>(
              icon: const Icon(Icons.layers, color: Colors.white),
              onSelected: (v) => setState(() => _selectedLayer = v),
              itemBuilder: (_) => _mapLayers.keys.map((k) => PopupMenuItem(value: k, child: Text(k))).toList(),
            ),
        ],
      ),
      body: Stack(children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(initialCenter: sanaaCenter, initialZoom: 13),
          children: [
            TileLayer(urlTemplate: layerUrl, userAgentPackageName: 'com.sehatak.app'),
            MarkerLayer(
              markers: _currentLocations.map((loc) {
                final lat = loc['lat'] as double;
                final lng = loc['lng'] as double;
                final isSelected = _selectedLocation?.latitude == lat && _selectedLocation?.longitude == lng;
                return Marker(
                  point: LatLng(lat, lng),
                  width: isSelected ? 44 : 32,
                  height: isSelected ? 44 : 32,
                  child: GestureDetector(
                    onTap: () { _goToLocation(lat, lng); _showLocationDetails(loc); },
                    child: Container(
                      decoration: BoxDecoration(color: _getMarkerColor(), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 4)]),
                      child: Icon(_icon, color: Colors.white, size: isSelected ? 22 : 14),
                    ),
                  ),
                );
              }).toList(),
            ),
            if (_currentPosition != null)
              MarkerLayer(markers: [Marker(point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude), width: 24, height: 24, child: Container(decoration: BoxDecoration(color: Colors.blue.withOpacity(0.3), shape: BoxShape.circle), child: const Icon(Icons.my_location, color: Colors.blue, size: 14)))]),
          ],
        ),
        Positioned(right: 10, bottom: 150, child: Column(children: [
          FloatingActionButton(heroTag: 'z_in', mini: true, onPressed: () => _mapController.move(_mapController.camera.center, _mapController.camera.zoom + 1), backgroundColor: AppColors.primary, child: const Icon(Icons.add, color: Colors.white)),
          const SizedBox(height: 6),
          FloatingActionButton(heroTag: 'z_out', mini: true, onPressed: () => _mapController.move(_mapController.camera.center, _mapController.camera.zoom - 1), backgroundColor: AppColors.primary, child: const Icon(Icons.remove, color: Colors.white)),
        ])),
        Positioned(left: 10, bottom: 150, child: FloatingActionButton(heroTag: 'my_loc', mini: true, onPressed: _getCurrentLocation, backgroundColor: AppColors.info, child: const Icon(Icons.my_location, color: Colors.white))),
        Positioned(bottom: 0, left: 0, right: 0, child: _buildLocationsList()),
        if (widget.type == 'tracking') Positioned(top: 10, left: 10, right: 10, child: _buildTrackingCard()),
      ]),
    );
  }

  Widget _buildLocationsList() {
    return Container(
      height: 130,
      decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, -2))]),
      child: Column(children: [
        Container(width: 36, height: 4, margin: const EdgeInsets.only(top: 8), decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(children: [Text('${_currentLocations.length} ${_title}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), const Spacer(), Text('اسحب للمزيد ←', style: TextStyle(fontSize: 10, color: Colors.grey[500]))]),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: _currentLocations.length,
            itemBuilder: (context, index) {
              final loc = _currentLocations[index];
              return GestureDetector(
                onTap: () => _goToLocation(loc['lat'], loc['lng']),
                child: Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 6, bottom: 6),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _selectedLocation?.latitude == loc['lat'] ? _getMarkerColor() : Colors.transparent, width: 1.5),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(loc['image'] ?? _icon, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 2),
                    Text(loc['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(loc['address'], style: const TextStyle(fontSize: 8, color: AppColors.grey), maxLines: 2, overflow: TextOverflow.ellipsis),
                    const Spacer(),
                    if (loc['phone'] != null) Row(children: [const Icon(Icons.phone, size: 9, color: AppColors.success), const SizedBox(width: 2), Text(loc['phone'], style: const TextStyle(fontSize: 8, color: AppColors.success))]),
                  ]),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildTrackingCard() {
    final steps = ["تم الطلب", "قيد التجهيز", "تم الشحن", "تم التوصيل"];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6)]),
      child: Column(children: [
        Row(children: [Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.local_shipping, color: AppColors.primary, size: 18)), const SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("طلبك في الطريق!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text("رقم الطلب: ${widget.orderId ?? "#SHK-784512"}", style: const TextStyle(fontSize: 9, color: AppColors.grey))]))]),
        const SizedBox(height: 10),
        Row(children: List.generate(steps.length, (i) => Expanded(child: Row(children: [Container(width: 12, height: 12, decoration: BoxDecoration(color: i < _currentStep ? AppColors.success : AppColors.grey, shape: BoxShape.circle), child: i < _currentStep ? const Icon(Icons.check, size: 7, color: Colors.white) : null), if (i < steps.length - 1) Expanded(child: Container(height: 2, color: i < _currentStep - 1 ? AppColors.success : AppColors.grey))])))),
        const SizedBox(height: 4),
        Row(children: List.generate(steps.length, (i) => Expanded(child: Text(steps[i], style: TextStyle(fontSize: 7, color: i < _currentStep ? AppColors.success : AppColors.grey), textAlign: TextAlign.center)))),
        const SizedBox(height: 6),
        Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.06), borderRadius: BorderRadius.circular(6)), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("⏱️ ", style: TextStyle(fontSize: 14)), Text("الوقت المتوقع: 18 دقيقة", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.success, fontSize: 11))])),
      ]),
    );
  }

  void _showLocationDetails(Map<String, dynamic> loc) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Text(loc['image'] ?? '', style: const TextStyle(fontSize: 32)), const SizedBox(width: 10), Expanded(child: Text(loc['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))]),
          const SizedBox(height: 10),
          if (loc['address'] != null) _detailRow(Icons.location_on, loc['address']),
          if (loc['phone'] != null) _detailRow(Icons.phone, loc['phone']),
          if (loc['hours'] != null) _detailRow(Icons.access_time, loc['hours']),
          if (loc['type'] != null) _detailRow(Icons.category, loc['type']),
          if (loc['beds'] != null) _detailRow(Icons.bed, '${loc['beds']} سرير'),
          if (loc['emergency'] == true) _detailRow(Icons.warning, 'طوارئ 24 ساعة'),
          if (loc['delivery'] == true) _detailRow(Icons.delivery_dining, 'توصيل متاح'),
          if (loc['tests'] != null) _detailRow(Icons.science, '${loc['tests']} فحص متاح'),
          if (loc['accredited'] == true) _detailRow(Icons.verified, 'معتمد'),
          if (loc['homeService'] == true) _detailRow(Icons.home, 'خدمة منزلية'),
          if (loc['specialties'] != null) _detailRow(Icons.medical_services, loc['specialties']),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: ElevatedButton.icon(onPressed: () async { final url = Uri.parse('tel:${loc['phone']}'); if (await canLaunchUrl(url)) launchUrl(url); }, icon: const Icon(Icons.call, size: 16), label: const Text('اتصال'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.success, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)))),
            const SizedBox(width: 8),
            Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.navigation, size: 16), label: const Text('توجيه'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)))),
          ]),
        ]),
      ),
    );
  }

  Widget _detailRow(IconData icon, String text) {
    return Padding(padding: const EdgeInsets.only(bottom: 4), child: Row(children: [Icon(icon, size: 14, color: AppColors.grey), const SizedBox(width: 6), Expanded(child: Text(text, style: const TextStyle(fontSize: 12)))]));
  }
}
