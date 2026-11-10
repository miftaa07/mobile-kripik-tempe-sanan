import 'package:flutter/material.dart';

class KnowledgeArticle {
  final String title;
  final String subtitle;
  final IconData icon;
  final String introduction;
  final List<KnowledgeSection> sections;

  const KnowledgeArticle({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.introduction,
    required this.sections,
  });
}

class KnowledgeSection {
  final String title;
  final String body;

  const KnowledgeSection({required this.title, required this.body});
}

const knowledgeArticles = [
  KnowledgeArticle(
    title: 'Sejarah Kampung Sanan',
    subtitle: 'Awal mula tradisi tempe sejak generasi pendahulu',
    icon: Icons.menu_book_outlined,
    introduction: 'Kampung Sanan tumbuh bersama tradisi pengolahan tempe yang diwariskan dari satu generasi ke generasi berikutnya. Dari lingkungan pengrajin rumahan, Sanan berkembang menjadi sentra tempe dan keripik tempe yang dikenal di Malang.',
    sections: [
      KnowledgeSection(
        title: 'Berawal dari usaha keluarga',
        body: 'Keterampilan mengolah kedelai menjadi tempe menjadi bagian dari kehidupan masyarakat Sanan. Resep, teknik, dan ketekunan bekerja di rumah diwariskan di dalam keluarga.',
      ),
      KnowledgeSection(
        title: 'Berkembang menjadi sentra',
        body: 'Ketika keripik tempe mulai diminati sebagai camilan dan oleh-oleh, semakin banyak warga mengembangkan usaha pengolahan dan penjualan. Kawasan ini pun dikenal sebagai sentra industri tempe di Malang.',
      ),
      KnowledgeSection(
        title: 'Tradisi yang terus hidup',
        body: 'Sampai sekarang, usaha keluarga dan pengrajin lokal menjadi bagian penting dari identitas Kampung Sanan, sambil terus menghadirkan cara dan rasa baru.',
      ),
    ],
  ),
  KnowledgeArticle(
    title: 'Pengetahuan tentang Tempe',
    subtitle: 'Kandungan gizi superfood kedelai pilihan Malang',
    icon: Icons.lightbulb_outline,
    introduction: 'Lahir dari kearifan lokal berabad-abad silam di tanah Jawa, tempe bukan sekadar olahan kedelai biasa. Ini adalah mahakarya bioteknologi tradisional warisan leluhur nusantara yang mengubah biji kedelai sederhana menjadi pangan kaya nutrisi dengan cita rasa gurih khas alami.',
    sections: [
      KnowledgeSection(
        title: 'Menjaga Kesehatan Pencernaan',
        body: 'Enzim pencernaan yang dihasilkan oleh kapang Rhizopus oligosporus menguraikan senyawa kompleks sehingga sangat lembut bagi lambung dan usus.',
      ),
      KnowledgeSection(
        title: 'Menurunkan Kolesterol & Kesehatan Jantung',
        body: 'Asam lemak tak jenuh dan niasin dalam tempe terbukti secara klinis membantu menyeimbangkan kadar lipid darah serta menjaga elastisitas pembuluh darah.',
      ),
      KnowledgeSection(
        title: 'Sumber Antioksidan Alami Isoflavon',
        body: 'Proses peragian melipatgandakan zat isoflavon aktif (daidzein dan genistein) yang efektif melawan radikal bebas dan memperlambat penuaan sel.',
      ),
    ],
  ),
  KnowledgeArticle(
    title: 'Proses Pembuatan Keripik Tempe',
    subtitle: 'Tahapan fermentasi, perajangan tipis & penggorengan',
    icon: Icons.spa_outlined,
    introduction: 'Kampung Sanan, Malang tersohor berkat dedikasi ratusan pengrajin rumahan yang menjaga standar rasa legendaris. Melalui ketelitian proses manual dan racikan bumbu khas, setiap butir kedelai disulap menjadi camilan renyah berkualitas tinggi.',
    sections: [
      KnowledgeSection(
        title: 'Pemilihan Kedelai & Perebusan',
        body: 'Biji kedelai murni pilihan dicuci bersih dan direbus sempurna untuk melepaskan kulit ari serta memastikan tekstur kedelai matang merata.',
      ),
      KnowledgeSection(
        title: 'Fermentasi Tradisional',
        body: 'Peragian menggunakan ragi tempe khusus selama 36–48 jam hingga jamur putih (miselium) tumbuh rapat dan memadat sempurna.',
      ),
      KnowledgeSection(
        title: 'Perajangan Tipis Khas Sanan',
        body: 'Keahlian mengiris tempe menjadi lembaran sangat tipis dan presisi dengan pisau tajam tradisional tanpa meremukkan tekstur kedelai.',
      ),
      KnowledgeSection(
        title: 'Pembumbuan Rempah Alami',
        body: 'Rempah pilihan seperti bawang putih, ketumbar sangrai, dan garam halus dibalurkan merata tanpa tambahan bahan pengawet buatan.',
      ),
      KnowledgeSection(
        title: 'Penggorengan Renyah Higienis',
        body: 'Minyak kelapa sawit berkualitas tinggi dengan suhu terkontrol untuk hasil renyah keemasan, tiris minyak maksimal, dan tahan lama.',
      ),
    ],
  ),
  KnowledgeArticle(
    title: 'Fakta & Informasi Tempe',
    subtitle: 'Statistik sentra, varian rasa & inovasi sirkular',
    icon: Icons.sell_outlined,
    introduction: 'Sanan bukan sekadar perkampungan biasa, melainkan denyut nadi gastronomi tempe terbesar di Nusantara yang memadukan keahlian turun-temurun dengan daya cipta rasa modern.',
    sections: [
      KnowledgeSection(
        title: 'Pusat Tempe Terbesar',
        body: 'Lebih dari 500 pengrajin aktif memproduksi keripik tempe setiap hari di Sanan Malang dengan resep khas keluarga.',
      ),
      KnowledgeSection(
        title: 'Mendunia',
        body: 'Kini dinikmati dan dipelajari di berbagai negara sebagai makanan masa depan bergizi super dan berprotein tinggi.',
      ),
      KnowledgeSection(
        title: '15+ Inovasi Varian Rasa',
        body: 'Mulai dari Original gurih, Pedas Daun Jeruk, Barbeque, Keju gurih, hingga sensasi unik Rumput Laut.',
      ),
      KnowledgeSection(
        title: 'Tahan Hingga 3–6 Bulan',
        body: 'Tanpa bahan pengawet sintetis berkat teknik penggorengan suhu presisi dan kemasan kedap udara higienis.',
      ),
    ],
  ),
];
