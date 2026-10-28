
import 'package:flutter/material.dart';
import 'main.dart';
import 'detail_page.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final filteredProducts = glowProducts.where((product) {
      final keyword = searchText.trim().toLowerCase();

      return (product['name'] ?? '')
          .toLowerCase()
          .contains(keyword) ||
          (product['category'] ?? '')
              .toLowerCase()
              .contains(keyword);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Katalog Skincare',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari produk skincare...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: glowPink,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Row(
              children: [
                const Text(
                  'Semua Produk',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: glowPink,
                  ),
                ),
                const Spacer(),
                Text('${filteredProducts.length} produk'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
              child: Text('Produk tidak ditemukan.'),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];

                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 12),
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
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            height: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: glowSoftPink,
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            child: Text(
                              product['emoji'] ?? '🧴',
                              style: const TextStyle(
                                fontSize: 32,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  product['category'] ?? '',
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  product['skin'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
