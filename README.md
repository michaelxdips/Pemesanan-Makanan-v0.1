# Pemesanan Makanan v0.1

Aplikasi mobile untuk pemesanan makanan dan minuman menggunakan Flutter dengan **Firebase Cloud Firestore** sebagai backend.

## ✨ Fitur

- 📋 Daftar menu dari **Firebase Firestore**
- 🖼️ Gambar menu dari **URL** (Firebase/Unsplash)
- 🛒 Keranjang belanja dengan penyimpanan persisten
- 💰 Perhitungan otomatis (Subtotal + Service Charge 7.5% + PB1 10%)
- 📱 Data tersimpan meskipun aplikasi ditutup
- 🎨 UI modern dengan gradients dan shadows

## 🚀 Quick Start

### 1. Setup Firebase (15 menit)

Lihat panduan lengkap di **[QUICKSTART.md](QUICKSTART.md)**

Singkatnya:
1. Buat Firebase project di https://console.firebase.google.com/
2. Enable Cloud Firestore (test mode)
3. Copy config ke `lib/firebase_options.dart`
4. Tambah data menu ke Firestore collection `menus`

### 2. Jalankan Aplikasi

```bash
flutter pub get
flutter run -d edge    # Web Browser (Recommended)
# or
flutter run -d chrome  # Alternative browser
```

**Platform Support:**
- ✅ Web (Edge/Chrome) - Ready to use
- ✅ Android - Requires emulator
- ⚠️ Windows Desktop - Requires Developer Mode
- ⚠️ iOS - Requires Mac

## Struktur Proyek

```
lib/
├── models/          # Model data
├── services/        # Services (cloud & local storage)
├── providers/       # State management
├── screens/         # Halaman UI
└── main.dart       # Entry point
```

## Teknologi

- Flutter SDK
- Provider (State Management)
- SharedPreferences (Local Storage)
- HTTP (Cloud Data)
