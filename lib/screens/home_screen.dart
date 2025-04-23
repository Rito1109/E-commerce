import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  OverlayEntry? _overlayEntry;
  final Map<String, GlobalKey> _dropdownKeys = {
    'Electronics': GlobalKey(),
    'Fashion': GlobalKey(),
    'Home': GlobalKey(),
    'Medical': GlobalKey(),
    'Toys': GlobalKey(),
    'Books': GlobalKey(),
  };

  final Map<String, List<String>> _dropdownItems = {
    'Electronics': ['Mobiles', 'Laptops', 'TVs'],
    'Fashion': ['Men', 'Women', 'Kids'],
    'Home': ['Furniture', 'Kitchen', 'Decor'],
    'Medical': ['Medicines', 'Supplements', 'Equipment'],
    'Toys': ['Action Figures', 'Educational', 'Puzzles'],
    'Books': ['Fiction', 'Non-fiction', 'Comics', 'Magazines'],
  };

  final List<String> _bannerImages = [
    'assets/banners/banner1.jpg',
    'assets/banners/banner2.jpg',
    'assets/banners/banner3.jpg',
    'assets/banners/banner4.jpg',
    'assets/banners/banner5.jpg',
    'assets/banners/banner6.jpg',
    'assets/banners/banner7.jpg',
    'assets/banners/banner8.jpg',
  ];

  final List<Map<String, String>> bestOfElectronics = [
    {'image': 'assets/products/projector.jpg', 'title': 'Projectors', 'subtitle': 'From ₹9999'},
    {'image': 'assets/products/earbuds.jpg', 'title': 'Best Truewireless H...', 'subtitle': 'Grab Now'},
    {'image': 'assets/products/printer.jpg', 'title': 'Printers', 'subtitle': 'From ₹3999'},
    {'image': 'assets/products/monitor1.jpg', 'title': 'Monitors', 'subtitle': 'From ₹6599'},
    {'image': 'assets/products/monitor2.jpg', 'title': 'Monitors', 'subtitle': 'From ₹7949'},
    {'image': 'assets/products/monitor3.jpg', 'title': 'Monitor', 'subtitle': 'From ₹8279'},
  ];

  final List<Map<String, String>> beautyFoodToys = [
    {'image': 'assets/products/coffee.jpg', 'title': 'Coffee Powder', 'subtitle': 'Upto 80% Off'},
    {'image': 'assets/products/stationery.jpg', 'title': 'Top Selling Stationery', 'subtitle': 'From ₹49'},
    {'image': 'assets/products/cycle.jpg', 'title': 'Geared Cycles', 'subtitle': 'Up to 70% Off'},
    {'image': 'assets/products/rc_toy.jpg', 'title': 'Remote Control Toys', 'subtitle': 'Up to 80% Off'},
    {'image': 'assets/products/action_toy.jpg', 'title': 'Best of Action Toys', 'subtitle': 'Up to 70% Off'},
    {'image': 'assets/products/teddy.jpg', 'title': 'Soft Toys', 'subtitle': 'Up to 70% Off'},
    {'image': 'assets/products/yoga_mat.jpg', 'title': 'Yoga Mat', 'subtitle': 'From ₹159'},
  ];

  bool _dropdownVisible = false;

  void _toggleDropdown(BuildContext context, String label) {
    if (_dropdownVisible) {
      _hideDropdown();
    } else {
      _showDropdown(context, label);
    }
  }

  void _showDropdown(BuildContext context, String label) {
    final key = _dropdownKeys[label];
    if (key == null) return;

    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final items = _dropdownItems[label] ?? [];

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        child: Material(
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map((item) => InkWell(
                onTap: () {
                  _hideDropdown();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: $item from $label')),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item),
                ),
              ))
                  .toList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _dropdownVisible = true;
  }

  void _hideDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _dropdownVisible = false;
  }

  Widget _buildProductSection(String title, List<Map<String, String>> items) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        const SizedBox(height: 8),
        (!isMobile && (title == 'Best of Electronics' || title == 'Beauty, Food, Toys & more'))
            ? SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: items.map((item) {
              return Container(
                width: 140,
                margin: const EdgeInsets.only(right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade200,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item['image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['title']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      item['subtitle']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        )
            : isMobile
            ? ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              leading: Image.asset(
                item['image']!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(item['title']!),
              subtitle: Text(item['subtitle']!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            );
          },
        )
            : GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisExtent: 200,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade200,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['title']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item['subtitle']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final categories = [
      {'image': 'assets/categories/kilos.png', 'label': 'Kilos'},
      {'image': 'assets/categories/mobiles.png', 'label': 'Mobiles'},
      {'image': 'assets/categories/fashion.png', 'label': 'Fashion'},
      {'image': 'assets/categories/electronics.png', 'label': 'Electronics'},
      {'image': 'assets/categories/home.png', 'label': 'Home'},
      {'image': 'assets/categories/appliances.png', 'label': 'Appliances'},
      {'image': 'assets/categories/medical.png', 'label': 'Medical'},
      {'image': 'assets/categories/toys.png', 'label': 'Toys'},
      {'image': 'assets/categories/books.png', 'label': 'Books'},
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text('Flipkart', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/seller');
            },
            icon: const Icon(Icons.storefront_outlined, color: Colors.teal),
            label: const Text('Become a Seller', style: TextStyle(color: Colors.teal)),
          ),
          IconButton(
            onPressed: () {},
            icon: const Row(
              children: [
                Icon(Icons.person_outline, color: Colors.black54),
                Icon(Icons.keyboard_arrow_down, color: Colors.black54),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black54)),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 6),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for Products, Brands and More',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          if (isMobile)
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(cat['image']!),
                        radius: 24,
                      ),
                      Text(cat['label']!, style: const TextStyle(fontSize: 12)),
                    ],
                  );
                },
              ),
            ),
          if (!isMobile)
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 24,
              runSpacing: 20,
              children: categories.map((category) {
                final label = category['label']!;
                final isDropdown = _dropdownKeys.containsKey(label);
                final key = isDropdown ? _dropdownKeys[label] : null;

                return GestureDetector(
                  onTap: () {
                    if (isDropdown) _toggleDropdown(context, label);
                  },
                  child: Column(
                    key: key,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Image.asset(
                            category['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 80,
                        child: Text(
                          label,
                          style: const TextStyle(fontSize: 13),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          const SizedBox(height: 24),
          CarouselSlider(
            items: _bannerImages.map((imagePath) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 180.0,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
            ),
          ),
          const SizedBox(height: 24),
          _buildProductSection("Best of Electronics", bestOfElectronics),
          const SizedBox(height: 24),
          _buildProductSection("Beauty, Food, Toys & more", beautyFoodToys),
        ],
      ),
    );
  }
}