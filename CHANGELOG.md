# Changelog

Semua perubahan penting pada proyek ini akan didokumentasikan di file ini.

## [0.1.0] - 2025-12-15

### ✨ Fitur Awal
- Halaman daftar menu dengan kategori (Makanan, Minuman, Snack)
- Menu diurutkan berdasarkan `urutanTampil` dalam kategori
- Keranjang belanja dengan penyimpanan persisten (SharedPreferences)
- Perhitungan pembayaran transparan:
  - Subtotal
  - Service Charge (7.5%)
  - PB1/Pajak (10%)
  - Total Akhir
- State management dengan Provider
- Mock data cloud service (siap diintegrasikan)

### 🏗️ Arsitektur
- Model layer: MenuModel, CartItem
- Service layer: MenuCloudService, CartLocalStorage
- Provider layer: MenuProvider, CartProvider
- Presentation layer: MenuListScreen, CartScreen

### 📱 UI/UX
- Material Design 3
- Pull to refresh
- Badge notifikasi keranjang
- Loading indicators
- Error handling dengan retry
- Konfirmasi dialog untuk aksi penting
- Format harga dengan separator ribuan
- Responsive layout

### 🔧 Technical Stack
- Flutter SDK
- Provider (State Management)
- SharedPreferences (Local Storage)
- HTTP package (untuk cloud integration)

### 📝 Dokumentasi
- README.md - Overview proyek
- DOKUMENTASI.md - Detail teknis lengkap
- PANDUAN_TESTING.md - Cara testing aplikasi
- CHANGELOG.md - History perubahan

### 🎯 Compliance
- ✅ Data dari cloud (mock, ready for integration)
- ✅ Atribut menu lengkap (id, namaMenu, gambar, harga, kategori, urutanTampil)
- ✅ Pencegahan duplikasi berdasarkan ID
- ✅ Menu per kategori dan sorted
- ✅ Keranjang persisten
- ✅ Perhitungan pembayaran transparan
- ✅ Arsitektur terpisah (Model, Service, Provider, UI)
- ✅ State management (Provider)
- ✅ Minimal 2 halaman (Menu + Cart)

### 🐛 Known Issues
- None (initial release)

### 🔮 Planned Features
- [ ] Integrasi Firebase/API untuk data cloud
- [ ] Halaman detail menu
- [ ] Search dan filter menu
- [ ] History pesanan
- [ ] Payment gateway integration
- [ ] User authentication
- [ ] Rating dan review
- [ ] Promo dan diskon

---

Format berdasarkan [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
