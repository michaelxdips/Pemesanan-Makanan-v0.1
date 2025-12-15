# Quick Start Guide - Firebase Integration

## ⚡ Langkah Cepat Setup Firebase

### 1. Buat Firebase Project (5 menit)

1. Buka https://console.firebase.google.com/
2. Klik **"Add project"**
3. Nama project: `pemesanan-makanan` (atau terserah Anda)
4. Nonaktifkan Google Analytics (optional)
5. Klik **"Create project"**

### 2. Enable Firestore (2 menit)

1. Di sidebar, klik **"Build"** → **"Firestore Database"**
2. Klik **"Create database"**
3. Pilih **"Start in test mode"** (untuk development)
4. Location: **"asia-southeast1 (Singapore)"**
5. Klik **"Enable"**

### 3. Daftarkan App Web (3 menit)

1. Di Project Overview, klik icon **Web (</> )**
2. App nickname: `Pemesanan Makanan Web`
3. **JANGAN** centang "Firebase Hosting"
4. Klik **"Register app"**
5. **COPY** konfigurasi Firebase yang muncul

### 4. Update firebase_options.dart (2 menit)

Buka file `lib/firebase_options.dart` dan ganti bagian `web` dengan konfigurasi yang Anda copy:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'AIzaSy...', // Ganti dengan API key Anda
  appId: '1:123...', // Ganti dengan App ID Anda
  messagingSenderId: '123...', // Ganti
  projectId: 'pemesanan-makanan', // Project ID Anda
  authDomain: 'pemesanan-makanan.firebaseapp.com',
  storageBucket: 'pemesanan-makanan.appspot.com',
);
```

### 5. Tambah Data Menu ke Firestore (5 menit)

#### Via Firebase Console (Recommended untuk pertama kali):

1. Buka **Firestore Database** di Firebase Console
2. Klik **"Start collection"**
3. Collection ID: `menus`
4. Klik **"Next"**
5. Tambahkan dokumen pertama:
   - **Document ID**: `M001`
   - Field 1: `namaMenu` (string) = `Nasi Goreng Spesial`
   - Field 2: `harga` (number) = `25000`
   - Field 3: `kategori` (string) = `Makanan`
   - Field 4: `urutanTampil` (number) = `1`
   - Field 5: `imageUrl` (string) = `https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=400`
6. Klik **"Save"**
7. Ulangi untuk menu lainnya (lihat data di bawah)

#### Data Menu Sample (Copy-Paste):

**M001** - Nasi Goreng Spesial:
```
namaMenu: "Nasi Goreng Spesial"
harga: 25000
kategori: "Makanan"
urutanTampil: 1
imageUrl: "https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=400"
```

**M002** - Mie Ayam:
```
namaMenu: "Mie Ayam"
harga: 18000
kategori: "Makanan"
urutanTampil: 2
imageUrl: "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400"
```

**D001** - Es Teh Manis:
```
namaMenu: "Es Teh Manis"
harga: 5000
kategori: "Minuman"
urutanTampil: 1
imageUrl: "https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=400"
```

**D002** - Es Jeruk:
```
namaMenu: "Es Jeruk"
harga: 8000
kategori: "Minuman"
urutanTampil: 2
imageUrl: "https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=400"
```

**S001** - Pisang Goreng:
```
namaMenu: "Pisang Goreng"
harga: 8000
kategori: "Snack"
urutanTampil: 1
imageUrl: "https://images.unsplash.com/photo-1587132137056-bfbf0166836e?w=400"
```

> **Tip**: Minimal 5 data untuk testing. Untuk data lengkap (13 menu), lihat `FIREBASE_SETUP.md`

### 6. Test Aplikasi (1 menit)

```bash
flutter run -d edge
```

### ✅ Checklist Sukses

Aplikasi berhasil jika:
- ✅ App running tanpa error
- ✅ Data menu muncul dari Firebase
- ✅ Gambar tampil dari URL
- ✅ Menu tergroup by kategori
- ✅ Bisa add to cart

### 🐛 Troubleshooting Cepat

**Error: "No Firebase App '[DEFAULT]' has been created"**
→ Pastikan sudah update `firebase_options.dart` dengan config yang benar

**Data tidak muncul**
→ Cek Firestore Console, pastikan collection name = `menus` (lowercase, plural)

**Gambar tidak muncul**
→ Test internet connection, atau coba URL placeholder:
`https://via.placeholder.com/150/FF5733/FFFFFF?text=Test`

### 📚 Dokumentasi Lengkap

- **Setup Detail**: Lihat `FIREBASE_SETUP.md`
- **Implementation**: Lihat `FIREBASE_IMPLEMENTATION.md`
- **Import Script**: Gunakan `tools/firebase_import.dart` untuk batch import

### 🎯 Next Steps

1. ✅ Test semua fitur app (menu, cart, payment)
2. ⚙️ Atur Firestore Security Rules untuk production
3. 📱 Test di platform lain (Android jika tersedia)
4. 🚀 Deploy ke Firebase Hosting (optional)

---

**Estimasi Total: 15-20 menit** ⏱️
**Difficulty: 🟢 Easy**
