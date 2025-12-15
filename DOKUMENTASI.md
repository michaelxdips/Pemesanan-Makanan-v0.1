# Dokumentasi Teknis - Pemesanan Makanan v0.1

## 📋 Daftar Isi
1. [Arsitektur Aplikasi](#arsitektur-aplikasi)
2. [Struktur Folder](#struktur-folder)
3. [Fitur Utama](#fitur-utama)
4. [Cara Penggunaan](#cara-penggunaan)
5. [Pengembangan Lebih Lanjut](#pengembangan-lebih-lanjut)

## 🏗️ Arsitektur Aplikasi

Aplikasi ini menggunakan arsitektur yang memisahkan concerns dengan jelas:

### Model Layer
- **MenuModel**: Representasi data menu dengan atribut id, namaMenu, gambar, harga, kategori, dan urutanTampil
- **CartItem**: Representasi item dalam keranjang dengan quantity dan timestamp

### Service Layer
- **MenuCloudService**: Mengelola pengambilan data menu dari cloud (saat ini mock data)
- **CartLocalStorage**: Mengelola penyimpanan keranjang ke SharedPreferences

### Provider Layer (State Management)
- **MenuProvider**: Mengelola state menu, loading, error, dan grouping berdasarkan kategori
- **CartProvider**: Mengelola state keranjang, perhitungan, dan operasi CRUD

### Presentation Layer
- **MenuListScreen**: Halaman utama menampilkan daftar menu berdasarkan kategori
- **CartScreen**: Halaman keranjang belanja dengan rincian pembayaran

## 📁 Struktur Folder

```
lib/
├── models/
│   ├── menu_model.dart          # Model data menu
│   └── cart_item.dart           # Model item keranjang
│
├── services/
│   ├── menu_cloud_service.dart  # Service untuk data cloud
│   └── cart_local_storage.dart  # Service penyimpanan lokal
│
├── providers/
│   ├── menu_provider.dart       # State management menu
│   └── cart_provider.dart       # State management keranjang
│
├── screens/
│   ├── menu_list_screen.dart    # Halaman daftar menu
│   └── cart_screen.dart         # Halaman keranjang
│
└── main.dart                    # Entry point aplikasi
```

## ✨ Fitur Utama

### 1. Daftar Menu
- ✅ Menampilkan menu berdasarkan kategori
- ✅ Menu diurutkan berdasarkan `urutanTampil` dalam setiap kategori
- ✅ Menampilkan gambar, nama, dan harga
- ✅ Tombol tambah ke keranjang dengan feedback visual
- ✅ Indikator jumlah item di keranjang untuk setiap menu
- ✅ Pull to refresh untuk memuat ulang data

### 2. Keranjang Belanja
- ✅ Penyimpanan persisten menggunakan SharedPreferences
- ✅ Data tetap tersimpan meskipun aplikasi ditutup
- ✅ Kontrol quantity (+/- untuk setiap item)
- ✅ Hapus item individual
- ✅ Kosongkan seluruh keranjang
- ✅ Urutan item berdasarkan waktu penambahan

### 3. Perhitungan Pembayaran
Rincian perhitungan transparan:
- **Subtotal**: Total harga semua item
- **Service Charge**: 7.5% dari subtotal
- **PB1 (Pajak)**: 10% dari (subtotal + service charge)
- **Total Akhir**: Subtotal + Service Charge + PB1

### 4. Pencegahan Duplikasi
- Validasi berdasarkan ID unik menu
- Jika menu sudah ada di keranjang, quantity akan bertambah
- Tidak ada menu dengan ID sama yang ditampilkan dua kali

## 🚀 Cara Penggunaan

### Setup Awal
```bash
# 1. Install dependencies
flutter pub get

# 2. Jalankan aplikasi
flutter run
```

### Penggunaan Aplikasi
1. **Lihat Menu**: Buka aplikasi untuk melihat daftar menu berdasarkan kategori
2. **Tambah ke Keranjang**: Tap tombol "Tambah" pada menu yang diinginkan
3. **Lihat Keranjang**: Tap icon keranjang di app bar
4. **Atur Quantity**: Gunakan tombol +/- di halaman keranjang
5. **Hapus Item**: Tap icon delete atau kurangi quantity hingga 0
6. **Lanjutkan**: Tap "Lanjutkan Pembayaran" untuk proses selanjutnya

## 🔧 Pengembangan Lebih Lanjut

### Integrasi Cloud Data (Firebase/API)
Ubah [menu_cloud_service.dart](lib/services/menu_cloud_service.dart):

```dart
Future<List<MenuModel>> fetchMenus() async {
  // Contoh dengan Firebase
  final snapshot = await FirebaseFirestore.instance
      .collection('menus')
      .orderBy('kategori')
      .get();
  
  return snapshot.docs
      .map((doc) => MenuModel.fromJson(doc.data()))
      .toList();
}
```

### Tambah Fitur Baru
Beberapa ide pengembangan:
- ✨ Halaman detail menu dengan deskripsi lengkap
- ✨ Fitur search dan filter menu
- ✨ History pesanan
- ✨ Integrasi payment gateway
- ✨ User authentication
- ✨ Rating dan review menu
- ✨ Promo dan diskon
- ✨ Multiple delivery address

### Optimisasi
- Implementasi image caching untuk performa lebih baik
- Lazy loading untuk list panjang
- Offline mode dengan sync data
- Analytics untuk tracking user behavior

## 📦 Dependencies

```yaml
provider: ^6.1.1           # State management
shared_preferences: ^2.2.2 # Local storage
http: ^1.1.2              # Networking (untuk cloud data)
```

## 🎯 Compliance dengan Requirements

| Requirement | Status | Implementasi |
|------------|--------|--------------|
| Data dari cloud | ✅ | MenuCloudService (siap diintegrasikan) |
| Atribut menu lengkap | ✅ | MenuModel dengan 6 atribut |
| Pencegahan duplikasi | ✅ | Validasi berdasarkan ID |
| Menu per kategori | ✅ | GroupedMenus dengan sorting |
| Urutan berdasarkan urutanTampil | ✅ | Sort di MenuCloudService |
| Keranjang persisten | ✅ | SharedPreferences |
| Perhitungan transparan | ✅ | Service Charge + PB1 ditampilkan |
| Arsitektur terpisah | ✅ | Model, Service, Provider, UI |
| State management | ✅ | Provider pattern |
| Min 2 halaman | ✅ | MenuListScreen + CartScreen |

## 📝 Catatan Tambahan

- Data menu saat ini adalah mock data untuk demo
- Gambar menggunakan placeholder dari via.placeholder.com
- Untuk production, ganti dengan data dan gambar asli
- Tambahkan error handling yang lebih robust
- Implementasi loading state untuk UX lebih baik
- Testing diperlukan sebelum production

## 🤝 Kontribusi

Untuk berkontribusi pada proyek ini:
1. Fork repository
2. Buat branch baru (`git checkout -b feature/AmazingFeature`)
3. Commit perubahan (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

---

**Pemesanan Makanan v0.1** - Dibuat dengan ❤️ menggunakan Flutter
