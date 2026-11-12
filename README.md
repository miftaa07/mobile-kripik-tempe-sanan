# Kampung Keripik Tempe Sanan

Aplikasi Flutter untuk menjelajahi produk, toko, pengetahuan, dan lokasi sentra
keripik tempe Kampung Sanan.

## Struktur MVVM

```text
lib/
├── core/
│   ├── di/              # Dependency container aplikasi
│   ├── theme/           # Tema bersama
│   └── utils/           # Utilitas lintas fitur
├── features/
│   ├── bantu_memilih/    # models, data_sources, repositories, viewmodels, views
│   ├── home/             # models, data_sources, repositories, viewmodels, views
│   ├── lokasi/           # models, data_sources, repositories, viewmodels, views
│   ├── navigation/       # viewmodels, views, widgets
│   ├── pengetahuan/      # models, data_sources, repositories, viewmodels, views
│   ├── splash/           # viewmodels, views
│   └── toko/             # models, data_sources, repositories, viewmodels, views, widgets
```

Alur data mengikuti `View → ViewModel → Repository → Data Source`. Data masih
menggunakan fixture lokal; backend API dan database belum diintegrasikan.
`AppDependencies` di `core/di` menyusun dependency repository aplikasi.

## Menjalankan dan menguji

```sh
flutter pub get
flutter run
flutter analyze
flutter test
```
