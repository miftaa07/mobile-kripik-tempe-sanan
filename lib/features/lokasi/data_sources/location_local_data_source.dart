import '../models/location_guide.dart';

class LocationLocalDataSource {
  const LocationLocalDataSource();

  LocationGuide getGuide() => const LocationGuide(
    address: 'Jl. Sanan, Kel. Purwantoro, Kec. Blimbing, Kota Malang, Jawa Timur 65122',
    area: 'Kelurahan Purwantoro, Kecamatan Blimbing, Kota Malang',
    transportOptions: [
      TransportOption(
        title: 'Dari Stasiun Kotabaru',
        duration: '± 10 Menit',
        description: 'Naik Angkutan Kota (Mikrolet kode AMG atau ASD) atau gunakan ojek/taksi online langsung menuju gerbang Jl. Sanan.',
      ),
      TransportOption(
        title: 'Dari Terminal Arjosari',
        duration: '± 12 Menit',
        description: 'Menuju ke arah selatan melewati poros Jl. Raden Intan dan Jl. Sunandar Priyosudarmo, belok kiri ke Jalan Sanan.',
      ),
      TransportOption(
        title: 'Dari Bandara Abd. Saleh',
        duration: '± 20 Menit',
        description: 'Tersedia taksi bandara resmi atau kendaraan sewa via jalan raya LA Sucipto langsung menuju persimpangan Blimbing.',
        byAir: true,
      ),
    ],
  );
}
