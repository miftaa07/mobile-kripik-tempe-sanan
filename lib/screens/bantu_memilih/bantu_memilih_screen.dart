import 'package:flutter/material.dart';

import 'rekomendasi_screen.dart';

const _brown = Color(0xFF7A3E12);
const _cream = Color(0xFFFBF6EE);
const _card = Color(0xFFF6EDE0);

class BantuMemilihScreen extends StatefulWidget {
  const BantuMemilihScreen({super.key});

  @override
  State<BantuMemilihScreen> createState() => _BantuMemilihScreenState();
}

class _BantuMemilihScreenState extends State<BantuMemilihScreen> {
  final budgets = [
    '<Rp10.000',
    'Rp10.000 - Rp20.000',
    'Rp20.000 - Rp30.000',
    '> Rp30.000',
  ];
  final rasas = ['Original', 'Pedas', 'Balado', 'Keju', 'Lainnya', 'Barbeque'];
  final ukurans = ['Kecil', 'Sedang', 'Besar', 'Bebas'];
  final tujuans = [
    'Cemilan sendiri',
    'Oleh-oleh',
    'Untuk keluarga',
    'Ingin mencoba',
  ];

  String? budget = 'Rp10.000 - Rp20.000';
  final Set<String> rasa = {'Original'};
  String? ukuran = 'Sedang';
  String? tujuan = 'Cemilan sendiri';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      appBar: AppBar(
        backgroundColor: _cream,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Bantu Saya Memilih',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _intro(),
          _section(
            Icons.account_balance_wallet_outlined,
            'Budget',
            'Pilih kisaran harga yang sesuai',
            _singleChips(
              budgets,
              budget,
              (v) => setState(() => budget = v),
              wide: true,
            ),
          ),
          _section(
            Icons.local_fire_department_outlined,
            'Rasa / Varian',
            'Pilih rasa yang kamu suka',
            _multiChips(),
          ),
          _section(
            Icons.straighten,
            'Ukuran',
            'Pilih ukuran kemasan',
            _singleChips(ukurans, ukuran, (v) => setState(() => ukuran = v)),
          ),
          _section(
            Icons.shopping_bag_outlined,
            'Tujuan Membeli',
            'Apa tujuan kamu membeli keripik tempe?',
            _singleChips(tujuans, tujuan, (v) => setState(() => tujuan = v)),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _brown,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.auto_awesome, size: 16),
              label: const Text(
                'Lihat Rekomendasi',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RekomendasiScreen(
                    budget: budget,
                    rasa: rasa,
                    ukuran: ukuran,
                    tujuan: tujuan,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _intro() => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _card,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundColor: _brown,
          child: Icon(Icons.smart_toy_outlined, color: Colors.white),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Hai! Aku bantu kamu menemukan toko atau produk keripik tempe yang paling cocok untukmu. Yuk, pilih preferensimu di bawah ini!',
            style: TextStyle(fontSize: 12, height: 1.4),
          ),
        ),
      ],
    ),
  );

  Widget _section(
    IconData icon,
    String title,
    String sub,
    Widget child,
  ) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _card,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: _brown),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(sub, style: const TextStyle(fontSize: 11, color: Colors.black54)),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );

  Widget _chip(String label, bool selected, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: selected ? _brown : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: selected ? _brown : Colors.black12),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: selected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      );

  Widget _singleChips(
    List<String> items,
    String? selected,
    ValueChanged<String> onSelect, {
    bool wide = false,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items
          .map((e) => _chip(e, selected == e, () => onSelect(e)))
          .toList(),
    );
  }

  Widget _multiChips() => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: rasas
        .map(
          (e) => _chip(e, rasa.contains(e), () {
            setState(() => rasa.contains(e) ? rasa.remove(e) : rasa.add(e));
          }),
        )
        .toList(),
  );
}
