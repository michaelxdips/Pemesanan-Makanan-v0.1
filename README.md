# Pemesanan Makanan v0.1

Aplikasi pemesanan makanan dan minuman menggunakan **Flutter** dengan **Firebase Cloud Firestore** sebagai backend database real-time.

![App Preview](screenshots/Screenshot%202025-12-15%20103712.png)

## ✨ Fitur Utama

- 📋 **Menu Real-time dari Firebase Firestore**
  - Data menu tersinkronisasi dengan cloud database
  - Kategori: Makanan, Minuman, Snack
  - Gambar HD dari Unsplash
  
- 🛒 **Keranjang Belanja Persisten**
  - Data keranjang tersimpan di browser (SharedPreferences)
  - Tetap ada meskipun aplikasi ditutup dan dibuka kembali
  - Badge notifikasi jumlah item

- 💰 **Perhitungan Otomatis**
  - Subtotal: Total harga semua item
  - Service Charge: 7.5% dari subtotal
  - PB1 (Pajak): 10% dari (subtotal + service charge)
  - Grand Total: Subtotal + Service Charge + PB1

- 🎨 **UI/UX Modern**
  - Gradient backgrounds
  - Smooth animations
  - Responsive design
  - Material Design 3

## 📸 Screenshots

### Menu Utama
![Menu List](screenshots/Screenshot%202025-12-15%20103712.png)
*Daftar menu lengkap dengan gambar HD, kategori, dan harga*

### Keranjang Belanja
![Shopping Cart](screenshots/Screenshot%202025-12-15%20103728.png)
*Keranjang dengan detail item, quantity control, dan breakdown biaya*

### Detail Checkout
![Checkout Detail](screenshots/Screenshot%202025-12-15%20104214.png)
*Rincian lengkap biaya termasuk service charge dan pajak*

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (3.0+)
- Firebase Account (Free tier)
- Edge/Chrome Browser atau Android Emulator

### 1. Clone Repository

```bash
git clone https://github.com/michaelxdips/Pemesanan-Makanan-v0.1.git
cd Pemesanan-Makanan-v0.1
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Setup Firebase

#### A. Buat Firebase Project
1. Buka [Firebase Console](https://console.firebase.google.com/)
2. Klik "Add Project" / "Tambah Project"
3. Beri nama project (contoh: `pemesanan-makanan`)
4. Disable Google Analytics (optional)
5. Klik "Create Project"

#### B. Enable Cloud Firestore
1. Di Firebase Console, buka **Firestore Database**
2. Klik **"Create database"**
3. Pilih **"Start in test mode"** (untuk development)
4. Pilih location: `asia-southeast2 (Jakarta)`
5. Klik **"Enable"**

#### C. Setup Web App
1. Di Project Overview, klik icon **Web** (</>) 
2. Register app dengan nama: `Pemesanan Makanan Web`
3. Copy Firebase Config code
4. Paste ke `lib/firebase_options.dart`:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'YOUR-API-KEY',
  appId: 'YOUR-APP-ID',
  messagingSenderId: 'YOUR-SENDER-ID',
  projectId: 'YOUR-PROJECT-ID',
  authDomain: 'YOUR-PROJECT.firebaseapp.com',
  storageBucket: 'YOUR-PROJECT.appspot.com',
);
```

#### D. Populate Data Menu
Jalankan script untuk import data menu:

```bash
flutter run tools/firebase_import.dart -d edge
```

Script akan mengisi Firestore dengan 13 menu items (5 Makanan, 5 Minuman, 3 Snack).

### 4. Jalankan Aplikasi

```bash
flutter run -d edge    # Web Browser (Recommended)
# atau
flutter run -d chrome
```

## 📁 Struktur Proyek

```
lib/
├── models/
│   ├── cart_item.dart          # Model item keranjang
│   └── menu_model.dart         # Model menu
├── services/
│   ├── firebase_service.dart   # Firebase Firestore operations
│   └── cart_local_storage.dart # SharedPreferences storage
├── providers/
│   ├── menu_provider.dart      # State management menu
│   └── cart_provider.dart      # State management cart
├── screens/
│   ├── menu_list_screen.dart   # Halaman daftar menu
│   └── cart_screen.dart        # Halaman keranjang
├── widgets/
│   └── menu_image_widget.dart  # Widget gambar menu
├── firebase_options.dart       # Firebase configuration
└── main.dart                   # Entry point

tools/
└── firebase_import.dart        # Script import data menu

android/
└── app/
    └── google-services.json    # Firebase Android config
```

## 🛠️ Teknologi Stack

### Frontend
- **Flutter 3.24+** - UI Framework
- **Material Design 3** - Design System
- **Provider 6.1+** - State Management

### Backend
- **Firebase Core 2.24+** - Firebase SDK
- **Cloud Firestore 4.14+** - NoSQL Database
- **SharedPreferences 2.2+** - Local Storage

### Development Tools
- **Dart 3.5+** - Programming Language
- **VS Code** - Code Editor

## 🔥 Firebase Firestore Structure

### Collection: `menus`

```json
{
  "id": "M001",
  "namaMenu": "Nasi Goreng Spesial",
  "imageUrl": "https://images.unsplash.com/...",
  "harga": 25000,
  "kategori": "Makanan",
  "urutanTampil": 1
}
```

**Fields:**
- `id` (string): Unique identifier (M001-M005, D001-D005, S001-S003)
- `namaMenu` (string): Nama menu
- `imageUrl` (string): URL gambar (Unsplash)
- `harga` (number): Harga dalam Rupiah
- `kategori` (string): Kategori menu (Makanan/Minuman/Snack)
- `urutanTampil` (number): Urutan tampilan di UI

## 💾 Local Storage (Cart)

Data keranjang disimpan menggunakan **SharedPreferences**:

```json
{
  "shopping_cart": [
    {
      "menu": { 
        "id": "M001",
        "namaMenu": "Nasi Goreng Spesial",
        "imageUrl": "...",
        "harga": 25000,
        "kategori": "Makanan",
        "urutanTampil": 1
      },
      "quantity": 2,
      "addedAt": "2025-12-15T10:37:00.000Z"
    }
  ]
}
```

## 🎯 Fitur Yang Akan Datang

- [ ] Authentication (Login/Register)
- [ ] Order History
- [ ] Payment Integration
- [ ] Admin Dashboard
- [ ] Real-time Order Tracking
- [ ] Push Notifications
- [ ] Rating & Review System

## 🤝 Kontribusi

Kontribusi sangat diterima! Silakan fork repository ini dan buat pull request.

1. Fork repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.

## 👨‍💻 Author

**Michael**
- GitHub: [@michaelxdips](https://github.com/michaelxdips)
- Repository: [Pemesanan-Makanan-v0.1](https://github.com/michaelxdips/Pemesanan-Makanan-v0.1)

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) - UI Framework
- [Firebase](https://firebase.google.com/) - Backend Platform
- [Unsplash](https://unsplash.com/) - Free Stock Photos
- [Material Design](https://m3.material.io/) - Design System

---

⭐ **Star repository ini jika bermanfaat!** ⭐
