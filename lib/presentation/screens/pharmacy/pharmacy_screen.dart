import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class PharmacyScreen extends StatefulWidget {
  const PharmacyScreen({super.key});
  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'الكل';
  int _cartCount = 0;

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.medication, 'name': 'الكل', 'color': AppColors.primary},
    {'icon': Icons.receipt, 'name': 'وصفة طبية', 'color': AppColors.error},
    {'icon': Icons.store, 'name': 'OTC', 'color': AppColors.info},
    {'icon': Icons.energy_savings_leaf, 'name': 'فيتامينات', 'color': AppColors.success},
    {'icon': Icons.face, 'name': 'عناية شخصية', 'color': AppColors.purple},
    {'icon': Icons.child_care, 'name': 'عناية بالأطفال', 'color': AppColors.pink},
  ];

  final List<Map<String, dynamic>> _medicines = [
    {'name': 'Panadol Extra', 'desc': 'Paracetamol 500mg', 'tablets': '24 Tablets', 'price': 120, 'oldPrice': 150, 'discount': '20%', 'image': '💊', 'category': 'OTC', 'brand': 'GSK'},
    {'name': 'Supradyn Daily', 'desc': 'Multivitamin', 'tablets': '30 Tablets', 'price': 1275, 'oldPrice': 1500, 'discount': '15%', 'image': '💊', 'category': 'فيتامينات', 'brand': 'Bayer'},
    {'name': 'Augmentin 625mg', 'desc': 'Amoxicillin + Clavulanic', 'tablets': '10 Tablets', 'price': 1162, 'oldPrice': 1550, 'discount': '25%', 'image': '💊', 'category': 'وصفة طبية', 'brand': 'GSK'},
    {'name': 'Voltral Emulgel', 'desc': 'Diclofenac Gel', 'tablets': '50g', 'price': 585, 'oldPrice': 650, 'discount': '10%', 'image': '🧴', 'category': 'OTC', 'brand': 'Novartis'},
    {'name': 'Becovit', 'desc': 'Vitamin B-Complex', 'tablets': '20 Tablets', 'price': 280, 'oldPrice': 350, 'discount': '20%', 'image': '💊', 'category': 'فيتامينات', 'brand': 'Pharmatec'},
    {'name': 'Calci-D', 'desc': 'Calcium + Vitamin D3', 'tablets': '30 Tablets', 'price': 850, 'oldPrice': 1000, 'discount': '15%', 'image': '💊', 'category': 'فيتامينات', 'brand': 'Bayer'},
    {'name': 'Risek 40mg', 'desc': 'Omeprazole', 'tablets': '14 Capsules', 'price': 540, 'oldPrice': 600, 'discount': '10%', 'image': '💊', 'category': 'وصفة طبية', 'brand': 'Getz Pharma'},
    {'name': 'Pampers Premium', 'desc': 'Diapers Size 4', 'tablets': '54 Pcs', 'price': 2400, 'oldPrice': 2800, 'discount': '14%', 'image': '👶', 'category': 'عناية بالأطفال', 'brand': 'Pampers'},
    {'name': 'Nivea Soft Cream', 'desc': 'Moisturizer', 'tablets': '200ml', 'price': 650, 'oldPrice': 750, 'discount': '13%', 'image': '🧴', 'category': 'عناية شخصية', 'brand': 'Nivea'},
    {'name': 'Surbex Z', 'desc': 'Zinc + Multivitamin', 'tablets': '30 Tablets', 'price': 350, 'oldPrice': 400, 'discount': '12%', 'image': '💊', 'category': 'فيتامينات', 'brand': 'Abbott'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصيدلية', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Stack(
            children: [
              IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
              if (_cartCount > 0)
                Positioned(right: 6, top: 6, child: Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle), child: Text('$_cartCount', style: const TextStyle(color: Colors.white, fontSize: 10)))),
            ],
          ),
        ],
      ),
      body: Column(children: [
        // شريط البحث والعنوان
        Container(
          padding: const EdgeInsets.all(14),
          color: AppColors.primary.withOpacity(0.03),
          child: Column(children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'ابحث عن أدوية، علامات تجارية...',
                prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.05), borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                const Icon(Icons.location_on, color: AppColors.primary, size: 18),
                const SizedBox(width: 6),
                const Expanded(child: Text('التوصيل إلى: Home - Block 7, Clifton', style: TextStyle(fontSize: 12))),
                TextButton.icon(onPressed: () {}, icon: const Icon(Icons.edit, size: 14), label: const Text('تغيير', style: TextStyle(fontSize: 11))),
              ]),
            ),
          ]),
        ),
        // التصنيفات
        SizedBox(
          height: 85,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final cat = _categories[index];
              final isSelected = _selectedCategory == cat['name'];
              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = cat['name']),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? cat['color'] : cat['color'].withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(cat['icon'], color: isSelected ? Colors.white : cat['color'], size: 22),
                  ),
                  const SizedBox(height: 4),
                  Text(cat['name'], style: TextStyle(fontSize: 10, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? AppColors.primary : AppColors.darkGrey)),
                ]),
              );
            },
          ),
        ),
        const Divider(height: 1),
        // المنتجات
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _medicines.length,
            itemBuilder: (context, index) => _buildMedicineCard(_medicines[index]),
          ),
        ),
      ]),
    );
  }

  Widget _buildMedicineCard(Map<String, dynamic> med) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // خصم
          Stack(children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              ),
              child: Center(child: Text(med['image'], style: const TextStyle(fontSize: 40))),
            ),
            Positioned(
              top: 8, left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(6)),
                child: Text(med['discount'] + ' OFF', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(med['brand'], style: const TextStyle(fontSize: 9, color: AppColors.grey)),
              const SizedBox(height: 2),
              Text(med['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text(med['desc'], style: const TextStyle(fontSize: 10, color: AppColors.darkGrey)),
              Text(med['tablets'], style: const TextStyle(fontSize: 9, color: AppColors.grey)),
              const SizedBox(height: 6),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Rs. ${med['price']}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 14)),
                  Text('Rs. ${med['oldPrice']}', style: const TextStyle(fontSize: 10, color: AppColors.grey, decoration: TextDecoration.lineThrough)),
                ]),
                GestureDetector(
                  onTap: () => setState(() => _cartCount++),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.add_shopping_cart, color: Colors.white, size: 16),
                  ),
                ),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}
