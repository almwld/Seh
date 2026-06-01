import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_dimensions.dart';
import 'cart_screen.dart';

class PharmacyProductsScreen extends StatefulWidget {
  final String pharmacyId;
  const PharmacyProductsScreen({super.key, required this.pharmacyId});

  @override
  State<PharmacyProductsScreen> createState() => _PharmacyProductsScreenState();
}

class _PharmacyProductsScreenState extends State<PharmacyProductsScreen> {
  final List<Map<String, dynamic>> _cart = [];

  final products = [
    {'name': 'بانادول إكسترا', 'price': 1200.0, 'category': 'مسكنات', 'requiresPrescription': false, 'inStock': true},
    {'name': 'أموكسيسيلين 500mg', 'price': 3500.0, 'category': 'مضادات حيوية', 'requiresPrescription': true, 'inStock': true},
    {'name': 'فيتامين سي', 'price': 800.0, 'category': 'فيتامينات', 'requiresPrescription': false, 'inStock': true},
    {'name': 'أوميبرازول 20mg', 'price': 2500.0, 'category': 'مضادات الحموضة', 'requiresPrescription': false, 'inStock': true},
    {'name': 'مترونيدازول', 'price': 1800.0, 'category': 'مضادات حيوية', 'requiresPrescription': true, 'inStock': false},
    {'name': 'جل الصبار', 'price': 1500.0, 'category': 'عناية بالبشرة', 'requiresPrescription': false, 'inStock': true},
  ];

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      final existing = _cart.indexWhere((item) => item['name'] == product['name']);
      if (existing >= 0) {
        _cart[existing]['quantity'] = (_cart[existing]['quantity'] as int) + 1;
      } else {
        _cart.add({...product, 'quantity': 1});
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تمت إضافة ${product['name']} إلى السلة')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المنتجات'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                },
              ),
              if (_cart.isNotEmpty)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        '${_cart.length}',
                        style: const TextStyle(color: AppColors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Icon(Icons.medication, color: AppColors.primary, size: 40)),
                ),
                const SizedBox(height: 12),
                Text(
                  product['name'] as String,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product['category'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey),
                ),
                const Spacer(),
                if (product['requiresPrescription'] as bool)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'يتطلب وصفة',
                      style: TextStyle(fontSize: 10, color: AppColors.warning),
                    ),
                  ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${product['price']} ${AppStrings.currencyYER}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    GestureDetector(
                      onTap: (product['inStock'] as bool) ? () => _addToCart(product) : null,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (product['inStock'] as bool) ? AppColors.primary : AppColors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add_shopping_cart, color: AppColors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
