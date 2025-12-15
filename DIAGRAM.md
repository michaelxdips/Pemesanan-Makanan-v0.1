# Diagram Arsitektur & Flow

## 📊 Struktur Arsitektur

```
┌─────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                    │
│  ┌──────────────────────┐  ┌──────────────────────┐    │
│  │  MenuListScreen      │  │    CartScreen        │    │
│  │  - Tampil menu       │  │  - Tampil keranjang  │    │
│  │  - Group by kategori │  │  - Rincian bayar     │    │
│  │  - Add to cart       │  │  - Update quantity   │    │
│  └──────────────────────┘  └──────────────────────┘    │
└─────────────────────────────────────────────────────────┘
                            ▼
┌─────────────────────────────────────────────────────────┐
│                     PROVIDER LAYER                       │
│  ┌──────────────────────┐  ┌──────────────────────┐    │
│  │   MenuProvider       │  │   CartProvider       │    │
│  │  - Load menus        │  │  - Load cart         │    │
│  │  - Group & sort      │  │  - Add/update/delete │    │
│  │  - Error handling    │  │  - Calculations      │    │
│  └──────────────────────┘  └──────────────────────┘    │
└─────────────────────────────────────────────────────────┘
                            ▼
┌─────────────────────────────────────────────────────────┐
│                      SERVICE LAYER                       │
│  ┌──────────────────────┐  ┌──────────────────────┐    │
│  │ MenuCloudService     │  │ CartLocalStorage     │    │
│  │  - Fetch from cloud  │  │  - Save to local     │    │
│  │  - Validate data     │  │  - Load from local   │    │
│  │  - Group by category │  │  - Clear cart        │    │
│  └──────────────────────┘  └──────────────────────┘    │
└─────────────────────────────────────────────────────────┘
                            ▼
┌─────────────────────────────────────────────────────────┐
│                      MODEL LAYER                         │
│  ┌──────────────────────┐  ┌──────────────────────┐    │
│  │    MenuModel         │  │     CartItem         │    │
│  │  - id                │  │  - menu              │    │
│  │  - namaMenu          │  │  - quantity          │    │
│  │  - gambar            │  │  - addedAt           │    │
│  │  - harga             │  │  - totalPrice        │    │
│  │  - kategori          │  │                      │    │
│  │  - urutanTampil      │  │                      │    │
│  └──────────────────────┘  └──────────────────────┘    │
└─────────────────────────────────────────────────────────┘
```

## 🔄 User Flow

### Flow 1: Melihat Menu
```
User membuka app
    ↓
MenuProvider.loadMenus()
    ↓
MenuCloudService.fetchMenus()
    ↓
Data menu ditampilkan berdasarkan kategori
    ↓
User melihat menu (sorted by urutanTampil)
```

### Flow 2: Menambah ke Keranjang
```
User tap tombol "Tambah"
    ↓
CartProvider.addToCart(menu)
    ↓
Check apakah menu sudah ada di cart
    ├── Sudah ada → Tambah quantity
    └── Belum ada → Tambah item baru
    ↓
CartLocalStorage.saveCart()
    ↓
Update UI dengan notifikasi
    ↓
Badge keranjang update otomatis
```

### Flow 3: Melihat Keranjang & Pembayaran
```
User tap icon keranjang
    ↓
Navigate ke CartScreen
    ↓
CartProvider.loadCart()
    ↓
CartLocalStorage.loadCart()
    ↓
Tampilkan list items
    ↓
Calculate:
    • Subtotal = Σ(harga × quantity)
    • Service Charge = Subtotal × 7.5%
    • PB1 = (Subtotal + Service Charge) × 10%
    • Grand Total = Subtotal + Service Charge + PB1
    ↓
Tampilkan rincian pembayaran
```

### Flow 4: Update Quantity
```
User tap tombol + atau -
    ↓
CartProvider.updateQuantity(menuId, newQuantity)
    ↓
Update quantity di memory
    ↓
CartLocalStorage.saveCart()
    ↓
Recalculate semua total
    ↓
Update UI
```

### Flow 5: Persistensi Data
```
User menambah items ke cart
    ↓
CartLocalStorage.saveCart()
    ↓
SharedPreferences.setString('shopping_cart', jsonData)
    ↓
User menutup aplikasi
    ↓
User membuka aplikasi lagi
    ↓
CartProvider.loadCart()
    ↓
CartLocalStorage.loadCart()
    ↓
SharedPreferences.getString('shopping_cart')
    ↓
Parse JSON → List<CartItem>
    ↓
Keranjang kembali seperti sebelumnya
```

## 💰 Rumus Perhitungan

```
SUBTOTAL = Σ (harga_menu × quantity)

SERVICE_CHARGE = SUBTOTAL × 0.075 (7.5%)

PB1 = (SUBTOTAL + SERVICE_CHARGE) × 0.10 (10%)

GRAND_TOTAL = SUBTOTAL + SERVICE_CHARGE + PB1
```

### Contoh Perhitungan:
```
Nasi Goreng Special: Rp 25.000 × 2 = Rp 50.000
Es Teh Manis: Rp 5.000 × 1 = Rp 5.000
Pisang Goreng: Rp 8.000 × 1 = Rp 8.000

SUBTOTAL = Rp 63.000
SERVICE_CHARGE = Rp 63.000 × 7.5% = Rp 4.725
PB1 = (Rp 63.000 + Rp 4.725) × 10% = Rp 6.772,5
GRAND_TOTAL = Rp 63.000 + Rp 4.725 + Rp 6.772,5 = Rp 74.497,5
```

## 🗂️ State Management dengan Provider

```
main.dart
    ↓
MultiProvider
    ├── MenuProvider (ChangeNotifier)
    │   └── Manages menu state globally
    └── CartProvider (ChangeNotifier)
        └── Manages cart state globally

Widget Tree:
    ↓
Consumer<MenuProvider>
    └── Listens to menu changes
    └── Rebuilds UI when notifyListeners() called

Consumer<CartProvider>
    └── Listens to cart changes
    └── Rebuilds UI when notifyListeners() called
```

## 🔐 Data Persistence

```
App Memory (Runtime)
    ↓
CartProvider._cartItems (List<CartItem>)
    ↓
CartLocalStorage.saveCart()
    ↓
JSON Serialization
    ↓
SharedPreferences
    ↓
Local Device Storage
    └── Key: 'shopping_cart'
    └── Value: JSON string of cart items

On App Restart:
Local Device Storage
    ↓
SharedPreferences.getString('shopping_cart')
    ↓
JSON Deserialization
    ↓
CartProvider._cartItems restored
```

## 🎨 Widget Hierarchy

```
MaterialApp
└── MenuListScreen
    ├── AppBar
    │   └── CartBadge (Consumer<CartProvider>)
    └── Body (Consumer<MenuProvider>)
        └── ListView
            └── CategorySection (foreach category)
                ├── CategoryHeader
                └── MenuList
                    └── MenuCard (foreach menu)
                        ├── Image
                        ├── MenuInfo
                        └── AddToCartButton (Consumer<CartProvider>)

CartScreen
├── AppBar
│   └── ClearCartButton
└── Body (Consumer<CartProvider>)
    ├── CartItemsList
    │   └── CartItemCard (foreach item)
    │       ├── Image
    │       ├── Info
    │       ├── QuantityControl (+/-)
    │       └── RemoveButton
    └── PaymentSummary
        ├── Subtotal
        ├── ServiceCharge
        ├── PB1
        ├── GrandTotal
        └── CheckoutButton
```

## 📱 Screen Transitions

```
┌──────────────────┐
│ MenuListScreen   │
│  (Home)          │
└────────┬─────────┘
         │ Tap cart icon
         ↓
┌──────────────────┐
│  CartScreen      │
│                  │
└────────┬─────────┘
         │ Back button
         ↓
┌──────────────────┐
│ MenuListScreen   │
│  (Updated badge) │
└──────────────────┘
```

---

Diagram ini menjelaskan alur kerja lengkap aplikasi dari arsitektur hingga flow user.
