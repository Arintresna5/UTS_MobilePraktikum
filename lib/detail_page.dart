
import 'package:flutter/material.dart';
import 'main.dart';
import 'favorite_service.dart';
import 'favorite_page.dart';

class DetailPage extends StatelessWidget {
  final Map<String, String> product;

  const DetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final productName = product['name'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Produk',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Lihat favorit',
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 210,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: glowSoftPink,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Text(
              product['emoji'] ?? '🧴',
              style: const TextStyle(fontSize: 90),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            productName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: glowPink,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product['price'] ?? '',
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Informasi Produk',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          infoItem('Kategori', product['category'] ?? '-'),
          infoItem('Jenis Kulit', product['skin'] ?? '-'),
          const SizedBox(height: 20),
          const Text(
            'Deskripsi Produk',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product['description'] ?? '',
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 30),
          ValueListenableBuilder<Set<String>>(
            valueListenable: FavoriteService.favorites,
            builder: (context, favorites, child) {
              final isFavorite = favorites.contains(productName);

              return ElevatedButton.icon(
                onPressed: () async {
                  await FavoriteService.toggleFavorite(productName);

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        FavoriteService.isFavorite(productName)
                            ? 'Produk ditambahkan ke favorit!'
                            : 'Produk dihapus dari favorit!',
                      ),
                    ),
                  );
                },
                icon: Icon(
                  isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                label: Text(
                  isFavorite
                      ? 'Hapus dari Favorit'
                      : 'Tambah ke Favorit',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: glowPink,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritePage(),
                ),
              );
            },
            icon: const Icon(Icons.favorite),
            label: const Text('Lihat Favorit Saya'),
            style: OutlinedButton.styleFrom(
              foregroundColor: glowPink,
              padding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoItem(String title, String value) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Text(title),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: glowPink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
