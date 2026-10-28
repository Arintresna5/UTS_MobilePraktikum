
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static final ValueNotifier<Set<String>> favorites =
  ValueNotifier<Set<String>>({});

  static const String storageKey = 'glowcare_favorites';

  static Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    favorites.value =
        prefs.getStringList(storageKey)?.toSet() ?? {};
  }

  static bool isFavorite(String productName) {
    return favorites.value.contains(productName);
  }

  static Future<void> toggleFavorite(String productName) async {
    final updated = Set<String>.from(favorites.value);

    if (updated.contains(productName)) {
      updated.remove(productName);
    } else {
      updated.add(productName);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(storageKey, updated.toList());

    favorites.value = updated;
  }
}
