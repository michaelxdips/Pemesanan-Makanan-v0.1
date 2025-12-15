# Setup Firebase untuk Aplikasi Pemesanan Makanan v0.1

## Langkah-Langkah Setup Firebase

### 1. Buat Firebase Project

1. Buka [Firebase Console](https://console.firebase.google.com/)
2. Klik "Add project" atau "Tambah proyek"
3. Masukkan nama project: `pemesanan-makanan` (atau nama lain)
4. Ikuti wizard setup hingga selesai

### 2. Tambahkan App ke Firebase Project

#### Untuk Web:
1. Di Firebase Console, pilih project Anda
2. Klik icon Web (</>) untuk menambahkan web app
3. Daftarkan app dengan nama: `Pemesanan Makanan Web`
4. Copy konfigurasi Firebase yang diberikan
5. Paste konfigurasi ke `lib/firebase_options.dart` bagian `web`

#### Untuk Android:
1. Klik icon Android untuk menambahkan Android app
2. Package name: `com.example.pemesanan_makanan`
3. Download `google-services.json` 
4. Letakkan di folder `android/app/`
5. Copy konfigurasi ke `lib/firebase_options.dart` bagian `android`

### 3. Enable Cloud Firestore

1. Di Firebase Console, pilih "Build" > "Firestore Database"
2. Klik "Create database"
3. Pilih mode:
   - **Test mode** (untuk development): Akses terbuka, expire dalam 30 hari
   - **Production mode**: Perlu atur security rules
4. Pilih location: `asia-southeast1` (Singapore) atau terdekat
5. Klik "Enable"

### 4. Setup Security Rules (Production Mode)

Jika menggunakan production mode, gunakan rules berikut di Firestore Rules:

\`\`\`
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow read access to menus collection
    match /menus/{menuId} {
      allow read: if true;
      allow write: if false; // Hanya admin yang bisa write
    }
  }
}
\`\`\`

### 5. Populate Data Menu ke Firestore

#### Option A: Manual via Firebase Console

1. Buka Firestore Database di Firebase Console
2. Klik "Start collection"
3. Collection ID: `menus`
4. Tambahkan dokumen dengan struktur berikut:

**Document ID**: `M001`
\`\`\`json
{
  "namaMenu": "Nasi Goreng Spesial",
  "harga": 25000,
  "kategori": "Makanan",
  "urutanTampil": 1,
  "imageUrl": "https://images.unsplash.com/photo-1603133872878-684f208fb84b"
}
\`\`\`

**Document ID**: `M002`
\`\`\`json
{
  "namaMenu": "Mie Ayam",
  "harga": 18000,
  "kategori": "Makanan",
  "urutanTampil": 2,
  "imageUrl": "https://images.unsplash.com/photo-1569718212165-3a8278d5f624"
}
\`\`\`

**Document ID**: `M003`
\`\`\`json
{
  "namaMenu": "Soto Ayam",
  "harga": 20000,
  "kategori": "Makanan",
  "urutanTampil": 3,
  "imageUrl": "https://images.unsplash.com/photo-1547592166-23ac45744acd"
}
\`\`\`

**Document ID**: `M004`
\`\`\`json
{
  "namaMenu": "Gado-Gado",
  "harga": 16000,
  "kategori": "Makanan",
  "urutanTampil": 4,
  "imageUrl": "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe"
}
\`\`\`

**Document ID**: `M005`
\`\`\`json
{
  "namaMenu": "Ayam Geprek",
  "harga": 22000,
  "kategori": "Makanan",
  "urutanTampil": 5,
  "imageUrl": "https://images.unsplash.com/photo-1598103442097-8b74394b95c6"
}
\`\`\`

**Document ID**: `D001`
\`\`\`json
{
  "namaMenu": "Es Teh Manis",
  "harga": 5000,
  "kategori": "Minuman",
  "urutanTampil": 1,
  "imageUrl": "https://images.unsplash.com/photo-1556679343-c7306c1976bc"
}
\`\`\`

**Document ID**: `D002`
\`\`\`json
{
  "namaMenu": "Es Jeruk",
  "harga": 8000,
  "kategori": "Minuman",
  "urutanTampil": 2,
  "imageUrl": "https://images.unsplash.com/photo-1600271886742-f049cd451bba"
}
\`\`\`

**Document ID**: `D003`
\`\`\`json
{
  "namaMenu": "Jus Alpukat",
  "harga": 12000,
  "kategori": "Minuman",
  "urutanTampil": 3,
  "imageUrl": "https://images.unsplash.com/photo-1623065422902-30a2d299bbe4"
}
\`\`\`

**Document ID**: `D004`
\`\`\`json
{
  "namaMenu": "Cappuccino",
  "harga": 18000,
  "kategori": "Minuman",
  "urutanTampil": 4,
  "imageUrl": "https://images.unsplash.com/photo-1572442388796-11668a67e53d"
}
\`\`\`

**Document ID**: `D005`
\`\`\`json
{
  "namaMenu": "Thai Tea",
  "harga": 10000,
  "kategori": "Minuman",
  "urutanTampil": 5,
  "imageUrl": "https://images.unsplash.com/photo-1576092768241-dec231879fc3"
}
\`\`\`

**Document ID**: `S001`
\`\`\`json
{
  "namaMenu": "Pisang Goreng",
  "harga": 8000,
  "kategori": "Snack",
  "urutanTampil": 1,
  "imageUrl": "https://images.unsplash.com/photo-1587132137056-bfbf0166836e"
}
\`\`\`

**Document ID**: `S002`
\`\`\`json
{
  "namaMenu": "Bakwan Jagung",
  "harga": 7000,
  "kategori": "Snack",
  "urutanTampil": 2,
  "imageUrl": "https://images.unsplash.com/photo-1601050690597-df0568f70950"
}
\`\`\`

**Document ID**: `S003`
\`\`\`json
{
  "namaMenu": "Tahu Crispy",
  "harga": 9000,
  "kategori": "Snack",
  "urutanTampil": 3,
  "imageUrl": "https://images.unsplash.com/photo-1546069901-ba9599a7e63c"
}
\`\`\`

#### Option B: Import via Script

Anda bisa membuat script untuk batch import. Simpan sebagai `firebase_import.dart` di folder root project:

\`\`\`dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestore = FirebaseFirestore.instance;
  
  // Data menu yang akan diimport
  final List<Map<String, dynamic>> menus = [
    {
      'id': 'M001',
      'namaMenu': 'Nasi Goreng Spesial',
      'harga': 25000,
      'kategori': 'Makanan',
      'urutanTampil': 1,
      'imageUrl': 'https://images.unsplash.com/photo-1603133872878-684f208fb84b',
    },
    // ... tambahkan menu lainnya
  ];

  // Import ke Firestore
  for (var menu in menus) {
    final id = menu['id'];
    menu.remove('id');
    
    await firestore.collection('menus').doc(id).set(menu);
    print('Added: \${menu['namaMenu']}');
  }

  print('Import completed!');
}
\`\`\`

Jalankan dengan: `dart run firebase_import.dart`

### 6. Update Firebase Configuration

Edit file `lib/firebase_options.dart` dan ganti placeholder dengan konfigurasi Firebase Anda:

- `YOUR_WEB_API_KEY` → Web API Key dari Firebase Console
- `YOUR_APP_ID` → App ID dari Firebase Console  
- `YOUR_PROJECT_ID` → Project ID dari Firebase Console
- dst.

### 7. Install Dependencies

Jalankan command berikut di terminal:

\`\`\`bash
flutter pub get
\`\`\`

### 8. Test Koneksi

Jalankan aplikasi dan pastikan:
- ✅ Tidak ada error Firebase initialization
- ✅ Data menu berhasil dimuat dari Firestore
- ✅ Gambar menu tampil dari URL

## Troubleshooting

### Error: "No Firebase App '[DEFAULT]' has been created"
**Solusi**: Pastikan `Firebase.initializeApp()` dipanggil di `main()` sebelum `runApp()`

### Error: "Missing or insufficient permissions"
**Solusi**: Periksa Firestore Security Rules, pastikan read access diizinkan

### Gambar tidak muncul
**Solusi**: 
- Cek URL gambar valid dan accessible
- Cek koneksi internet
- Lihat error di console Flutter

### Data tidak muncul
**Solusi**:
- Cek Firestore Console apakah collection `menus` ada
- Cek structure data sesuai dengan model
- Lihat error di Flutter console

## Sumber Gambar Alternatif

Jika ingin menggunakan gambar lain:

1. **Unsplash**: https://unsplash.com (gratis, high quality)
2. **Pexels**: https://pexels.com (gratis)
3. **Firebase Storage**: Upload gambar sendiri
4. **URL publik**: Link gambar dari server sendiri

## Next Steps

Setelah Firebase berhasil setup:

1. ✅ Test fetching data dari Firestore
2. ✅ Verify gambar tampil dengan baik
3. ✅ Test di berbagai platform (Web, Android)
4. ✅ Monitor usage di Firebase Console
5. ✅ Setup production security rules sebelum deploy

## Support

Jika ada masalah, periksa:
- Firebase Console untuk errors
- Flutter console untuk exceptions
- Firestore tab di Firebase Console untuk data structure
