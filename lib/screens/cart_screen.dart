import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';
import '../widgets/menu_image_widget.dart';

/// Halaman keranjang belanja dengan perhitungan pembayaran
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang Belanja',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              if (cart.itemCount > 0) {
                return IconButton(
                  icon: const Icon(Icons.delete_sweep),
                  onPressed: () => _showClearCartDialog(context),
                  tooltip: 'Kosongkan Keranjang',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (cart.itemCount == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.orange.shade100, Colors.orange.shade50],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.orange.shade300,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Keranjang Anda Kosong',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tambahkan menu untuk memulai pesanan',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.orange, Colors.deepOrange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.restaurant_menu, size: 24),
                      label: const Text(
                        'Lihat Menu',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange.shade50.withOpacity(0.3),
                  Colors.white,
                  Colors.orange.shade50.withOpacity(0.2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                // List item keranjang
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: cart.itemCount,
                    itemBuilder: (context, index) {
                      final cartItem = cart.cartItems[index];
                      return _CartItemCard(cartItem: cartItem);
                    },
                  ),
                ),
                // Summary pembayaran
                _PaymentSummary(cart: cart),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kosongkan Keranjang?'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus semua item dari keranjang?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              context.read<CartProvider>().clearCart();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Keranjang berhasil dikosongkan'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget untuk card item di keranjang
class _CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const _CartItemCard({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final menu = cartItem.menu;
    final cart = context.read<CartProvider>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.orange.shade50.withOpacity(0.2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Gambar menu
              MenuImageWidget(
                imageUrl: menu.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                borderRadius: 8,
              ),
              const SizedBox(width: 12),
              // Info menu
              Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.namaMenu,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${_formatNumber(menu.harga)}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Kontrol quantity
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        // Tombol kurang
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: cartItem.quantity > 1
                                  ? [Colors.orange.shade300, Colors.orange.shade400]
                                  : [Colors.red.shade300, Colors.red.shade400],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: (cartItem.quantity > 1 ? Colors.orange : Colors.red)
                                    .withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              if (cartItem.quantity > 1) {
                                cart.updateQuantity(
                                  menu.id,
                                  cartItem.quantity - 1,
                                );
                              } else {
                                _showRemoveDialog(context, cart, menu.id);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(6),
                              child: Icon(
                                Icons.remove,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // Quantity
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '${cartItem.quantity}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        // Tombol tambah
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.green, Colors.lightGreen],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              cart.updateQuantity(
                                menu.id,
                                cartItem.quantity + 1,
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(6),
                              child: Icon(
                                Icons.add,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ),
              // Total harga item & tombol hapus
              Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Rp ${_formatNumber(cartItem.totalPrice)}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 8),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => _showRemoveDialog(context, cart, menu.id),
                  tooltip: 'Hapus',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRemoveDialog(BuildContext context, CartProvider cart, String menuId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Item?'),
        content: const Text('Apakah Anda yakin ingin menghapus item ini dari keranjang?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              cart.removeFromCart(menuId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item dihapus dari keranjang'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double number) {
    return number.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }
}

/// Widget untuk summary pembayaran
class _PaymentSummary extends StatelessWidget {
  final CartProvider cart;

  const _PaymentSummary({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.orange.shade50.withOpacity(0.3)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade400, Colors.deepOrange.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, color: Colors.white, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Rincian Pembayaran',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Subtotal
            _buildSummaryRow(
              'Subtotal',
              cart.subtotal,
              isSubtitle: true,
            ),
            const SizedBox(height: 8),
            // Service Charge
            _buildSummaryRow(
              'Service Charge (7.5%)',
              cart.serviceCharge,
              isSubtitle: true,
            ),
            const SizedBox(height: 8),
            // PB1
            _buildSummaryRow(
              'PB1 (10%)',
              cart.pb1,
              isSubtitle: true,
            ),
            const Divider(height: 24),
            // Grand Total
            _buildSummaryRow(
              'Total Pembayaran',
              cart.grandTotal,
              isTotal: true,
            ),
            const SizedBox(height: 20),
            // Tombol Checkout (placeholder)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.green, Colors.lightGreen],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implementasi proses checkout
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.info_outline, color: Colors.white),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Fitur checkout akan segera hadir!',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.blue.shade600,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.payment, size: 24),
                    const SizedBox(width: 12),
                    const Text(
                      'Lanjutkan Pembayaran',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isSubtitle = false, bool isTotal = false}) {
    if (isTotal) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade100, Colors.orange.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange.shade300, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance_wallet, color: Colors.orange.shade700, size: 24),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade900,
                  ),
                ),
              ],
            ),
            Text(
              'Rp ${_formatNumber(amount)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
      );
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isSubtitle ? Colors.grey.shade700 : Colors.black87,
            ),
          ),
          Text(
            'Rp ${_formatNumber(amount)}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isSubtitle ? Colors.grey.shade700 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double number) {
    return number.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }
}
