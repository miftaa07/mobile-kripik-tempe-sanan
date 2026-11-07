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
    introduction: 'Tempe adalah makanan hasil fermentasi kedelai yang telah lama menjadi bagian dari hidangan sehari-hari di Indonesia. Proses fermentasi menghasilkan cita rasa dan tekstur khas.',
    sections: [
      KnowledgeSection(
        title: 'Bahan sederhana, kaya manfaat',
        body: 'Kedelai merupakan sumber protein nabati dan juga mengandung serat serta berbagai zat gizi. Kandungan gizi tempe dapat berbeda bergantung pada bahan dan proses pembuatannya.',
      ),
      KnowledgeSection(
        title: 'Apa itu fermentasi?',
        body: 'Dalam pembuatan tempe, kedelai yang telah disiapkan difermentasi dengan ragi tempe. Fermentasi membantu membentuk tekstur padat dan aroma khas tempe.',
      ),
      KnowledgeSection(
        title: 'Cara menikmati',
        body: 'Tempe dapat diolah menjadi beragam hidangan, mulai dari lauk sederhana hingga keripik tempe yang renyah. Nikmati sebagai bagian dari pola makan yang beragam dan seimbang.',
      ),
    ],
  ),
  KnowledgeArticle(
    title: 'Proses Pembuatan Keripik Tempe',
    subtitle: 'Tahapan fermentasi, perajangan tipis & penggorengan',
    icon: Icons.spa_outlined,
    introduction: 'Keripik tempe yang renyah berawal dari tempe berkualitas. Setiap tahap, dari fermentasi sampai pengemasan, ikut menentukan tekstur dan rasa akhirnya.',
    sections: [
      KnowledgeSection(
        title: '1. Menyiapkan kedelai',
        body: 'Kedelai dibersihkan, direndam, lalu direbus agar siap untuk proses pembuatan tempe. Kebersihan bahan dan peralatan penting untuk menjaga mutu.',
      ),
      KnowledgeSection(
        title: '2. Fermentasi tempe',
        body: 'Kedelai yang sudah dingin dicampur ragi dan diperam hingga menyatu menjadi tempe. Lama pemeraman disesuaikan dengan kondisi dan cara kerja pengrajin.',
      ),
      KnowledgeSection(
        title: '3. Merajang dan membumbui',
        body: 'Tempe diiris tipis, kemudian dibalut adonan berbumbu. Irisan yang rata membantu keripik matang lebih merata.',
      ),
      KnowledgeSection(
        title: '4. Menggoreng dan mengemas',
        body: 'Irisan digoreng hingga renyah, ditiriskan, lalu dikemas setelah dingin agar kualitasnya tetap terjaga.',
      ),
    ],
  ),
  KnowledgeArticle(
    title: 'Fakta & Informasi Tempe',
    subtitle: 'Statistik sentra, varian rasa & inovasi sirkular',
    icon: Icons.sell_outlined,
    introduction: 'Di Kampung Sanan, tempe bukan hanya bahan makanan, tetapi juga bagian dari kegiatan dan kreativitas warga. Berikut beberapa hal menarik tentang produk olahan tempe di Sanan.',
    sections: [
      KnowledgeSection(
        title: 'Ragam rasa',
        body: 'Keripik tempe tersedia dalam beragam pilihan rasa, dari original hingga aneka bumbu gurih dan pedas. Setiap pengrajin dapat memiliki racikan khasnya sendiri.',
      ),
      KnowledgeSection(
        title: 'Pilihan untuk oleh-oleh',
        body: 'Selain kemasan camilan, pengunjung dapat menemukan pilihan ukuran dan paket yang cocok dibawa pulang atau dibagikan kepada keluarga.',
      ),
      KnowledgeSection(
        title: 'Kreasi dan pemanfaatan',
        body: 'Pengrajin terus berkreasi melalui variasi rasa dan kemasan. Pemanfaatan bahan secara bijak juga menjadi bagian dari upaya menjaga kegiatan produksi tetap berkelanjutan.',
      ),
    ],
  ),
];
