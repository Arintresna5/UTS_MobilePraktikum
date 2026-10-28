
import 'package:flutter/material.dart';
import 'catalog_page.dart';
import 'detail_page.dart';
import 'favorite_page.dart';
import 'favorite_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoriteService.loadFavorites();
  runApp(const GlowCareApp());
}

const Color glowPink = Color(0xFFB85F7C);
const Color glowSoftPink = Color(0xFFF7E0E6);
const Color glowCream = Color(0xFFFFF8F7);

const List<Map<String, String>> glowProducts = [
  {
    'name': 'Gentle Facial Cleanser',
    'category': 'Cleanser',
    'price': 'Rp45.000',
    'skin': 'Semua jenis kulit',
    'emoji': '🧴',
    'description':
    'Pembersih wajah yang membantu membersihkan kotoran dan '
        'minyak dari permukaan kulit. Cocok untuk rutinitas '
        'perawatan wajah sehari-hari.',
  },
  {
    'name': 'Hydrating Serum',
    'category': 'Serum',
    'price': 'Rp75.000',
    'skin': 'Kulit kering',
    'emoji': '💧',
    'description':
    'Serum dengan fokus pada hidrasi untuk membantu '
        'menjaga kelembapan kulit dan membuat kulit terasa nyaman.',
  },
  {
    'name': 'Daily Sunscreen SPF',
    'category': 'Sunscreen',
    'price': 'Rp60.000',
    'skin': 'Semua jenis kulit',
    'emoji': '☀️',
    'description':
    'Tabir surya untuk penggunaan sehari-hari. '
        'Gunakan sesuai petunjuk pada kemasan untuk '
        'membantu melindungi kulit dari sinar matahari.',
  },
  {
    'name': 'Moisturizing Cream',
    'category': 'Moisturizer',
    'price': 'Rp55.000',
    'skin': 'Kulit normal',
    'emoji': '🌸',
    'description':
    'Krim pelembap untuk membantu menjaga kelembapan '
        'dan kenyamanan kulit dalam rutinitas skincare.',
  },
  {
    'name': 'Refreshing Toner',
    'category': 'Toner',
    'price': 'Rp40.000',
    'skin': 'Kulit berminyak',
    'emoji': '🫧',
    'description':
    'Toner yang memberikan sensasi segar setelah '
        'membersihkan wajah dan melengkapi rutinitas skincare.',
  },
];

class GlowCareApp extends StatelessWidget {
  const GlowCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlowCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: glowPink),
        scaffoldBackgroundColor: glowCream,
        appBarTheme: const AppBarTheme(
          backgroundColor: glowCream,
          foregroundColor: glowPink,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openCatalog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CatalogPage(),
      ),
    );
  }

  void openFavorites(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FavoritePage(),
      ),
    );
  }

  void openDetail(
      BuildContext context,
      Map<String, String> product,
      ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GlowCare ♡',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Favorit Saya',
            icon: const Icon(Icons.favorite_border),
            onPressed: () => openFavorites(context),
          ),
          IconButton(
            tooltip: 'Katalog',
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () => openCatalog(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: glowSoftPink,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HELLO, GLOW GIRL! ✨',
                  style: TextStyle(
                    color: glowPink,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Temukan skincare yang cocok untuk '
                      'kebutuhan kulitmu.',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 10),
                Text(
                  'Your skin deserves the best care ♡',
                  style: TextStyle(
                    color: glowPink,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Kategori Skincare',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: glowPink,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              categoryItem(context, '🧴', 'Cleanser'),
              const SizedBox(width: 10),
              categoryItem(context, '💧', 'Serum'),
              const SizedBox(width: 10),
              categoryItem(context, '☀️', 'Sunscreen'),
            ],
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Rekomendasi Produk',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: glowPink,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => openCatalog(context),
                child: const Text(
                  'Lihat Semua',
                  style: TextStyle(color: glowPink),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...glowProducts.take(3).map(
                (product) => productItem(context, product),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => openCatalog(context),
              icon: const Icon(Icons.grid_view),
              label: const Text('Jelajahi Katalog Skincare'),
              style: ElevatedButton.styleFrom(
                backgroundColor: glowPink,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => openFavorites(context),
              icon: const Icon(Icons.favorite),
              label: const Text('Lihat Favorit Saya'),
              style: OutlinedButton.styleFrom(
                foregroundColor: glowPink,
                padding: const EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget categoryItem(
      BuildContext context,
      String emoji,
      String title,
      ) {
    return Expanded(
      child: InkWell(
        onTap: () => openCatalog(context),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: glowPink,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productItem(
      BuildContext context,
      Map<String, String> product,
      ) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => openDetail(context, product),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 75,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: glowSoftPink,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  product['emoji'] ?? '🧴',
                  style: const TextStyle(fontSize: 32),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(product['category'] ?? ''),
                    const SizedBox(height: 5),
                    Text(
                      product['price'] ?? '',
                      style: const TextStyle(
                        color: glowPink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: glowPink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
