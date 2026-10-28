
import 'package:flutter/material.dart';
import 'main.dart';
import 'detail_page.dart';
import 'favorite_service.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorit Saya ♡',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ValueListenableBuilder<Set<String>>(
        valueListenable: FavoriteService.favorites,
        builder: (context, favorites, child) {
          final favoriteProducts = glowProducts.where((product) {
            return favorites.contains(product['name']);
          }).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: glowSoftPink,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Favorite Skincare 💕',
                      style: TextStyle(
                        color: glowPink,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Kumpulan produk skincare yang kamu sukai.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '${favoriteProducts.length} Produk Favorit',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: glowPink,
                ),
              ),
              const SizedBox(height: 15),
              if (favoriteProducts.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 70),
                  child: Column(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 70,
                        color: glowPink,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Belum ada produk favorit.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tambahkan produk dari halaman detail.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                ...favoriteProducts.map((product) {
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 65,
                            height: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: glowSoftPink,
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            child: Text(
                              product['emoji'] ?? '🧴',
                              style: const TextStyle(fontSize: 30),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      product: product,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'] ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    product['price'] ?? '',
                                    style: const TextStyle(
                                      color: glowPink,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    'Lihat Detail',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Hapus dari favorit',
                            icon: const Icon(
                              Icons.favorite,
                              color: glowPink,
                            ),
                            onPressed: () async {
                              await FavoriteService.toggleFavorite(
                                product['name']!,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            ],
          );
        },
      ),
    );
  }
}
