import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';

/// Service untuk penyimpanan lokal keranjang belanja
class CartLocalStorage {
  static const String _cartKey = 'shopping_cart';

  /// Simpan keranjang ke local storage
  Future<void> saveCart(List<CartItem> cartItems) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = cartItems.map((item) => item.toJson()).toList();
      final cartString = jsonEncode(cartJson);
      await prefs.setString(_cartKey, cartString);
    } catch (e) {
      throw Exception('Gagal menyimpan keranjang: $e');
    }
  }

  /// Load keranjang dari local storage
  Future<List<CartItem>> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartString = prefs.getString(_cartKey);

      if (cartString == null || cartString.isEmpty) {
        return [];
      }

      final List<dynamic> cartJson = jsonDecode(cartString);
      return cartJson
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Gagal memuat keranjang: $e');
    }
  }

  /// Clear keranjang dari local storage
  Future<void> clearCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cartKey);
    } catch (e) {
      throw Exception('Gagal menghapus keranjang: $e');
    }
  }

  /// Check apakah ada data keranjang tersimpan
  Future<bool> hasCartData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_cartKey);
    } catch (e) {
      return false;
    }
  }
}
