import 'package:flutter_firebase/features/domain/entities/pdf_entity.dart';

class PdfDataSource {
  final List<PdfEntity> _pdfList = [
    PdfEntity(
      id: '1',
      judul: 'Seminar Nasional: Inovasi Terkini dalam Teknologi Informasi',
      penulis: 'Dewi Indah Sari',
      deskripsi:
          'Proposal ini berisi rencana dan tujuan acara Seminar Nasional yang akan diselenggarakan oleh Himpunan Mahasiswa Teknik Informatika. Acara ini bertujuan untuk membahas inovasi terkini dalam bidang Teknologi Informasi dan memperkuat koneksi antara mahasiswa dan para praktisi industri.',
      assetPath: 'assets/pdf/proposal_seminar_nasional_ti.pdf',
    ),

    PdfEntity(
      id: '2',
      judul:
          'Laporan Pertanggungjawaban Seminar Nasional: Inovasi Terkini dalam Teknologi Informasi',
      penulis: 'Ahmad Fauzi',
      deskripsi:
          'Laporan Pertanggungjawaban ini berisi rincian pengeluaran, capaian, dan hasil dari Seminar Nasional yang telah dilaksanakan oleh Himpunan Mahasiswa Teknik Informatika. Tujuan dari laporan ini adalah untuk memberikan transparansi terhadap penggunaan dana dan mengevaluasi keberhasilan kegiatan.',
      assetPath: 'assets/pdf/laporan_seminar_nasional_ti.pdf',
    ),

    PdfEntity(
      id: '3',
      judul: 'Proposal Workshop: Pengembangan Aplikasi Mobile dengan Flutter',
      penulis: 'Budi Pratama',
      deskripsi:
          'Proposal ini memaparkan rencana pelaksanaan workshop pengembangan aplikasi mobile menggunakan Flutter. Workshop ini ditujukan untuk memberikan pengetahuan praktis kepada mahasiswa Teknik Informatika dalam mengembangkan aplikasi mobile secara efektif.',
      assetPath: 'assets/pdf/proposal_workshop_flutter.pdf',
    ),

    PdfEntity(
      id: '4',
      judul:
          'Laporan Pertanggungjawaban Workshop: Pengembangan Aplikasi Mobile dengan Flutter',
      penulis: 'Citra Purnama',
      deskripsi:
          'Laporan ini merinci kegiatan workshop pengembangan aplikasi mobile dengan Flutter yang telah diselenggarakan. Dokumen ini mencakup evaluasi, feedback peserta, dan penggunaan dana untuk kegiatan tersebut.',
      assetPath: 'assets/pdf/laporan_workshop_flutter.pdf',
    ),

    PdfEntity(
      id: '5',
      judul:
          'Proposal Hackathon: Inovasi dan Kreativitas dalam Pengembangan Perangkat Lunak',
      penulis: 'Farhan Abdullah',
      deskripsi:
          'Proposal ini mendeskripsikan rencana penyelenggaraan hackathon bagi mahasiswa Teknik Informatika. Kegiatan ini bertujuan untuk menggali inovasi dan kreativitas dalam pengembangan perangkat lunak serta meningkatkan kemampuan pemecahan masalah.',
      assetPath: 'assets/pdf/proposal_hackathon_ti.pdf',
    ),

    PdfEntity(
      id: '6',
      judul:
          'Laporan Pertanggungjawaban Hackathon: Inovasi dan Kreativitas dalam Pengembangan Perangkat Lunak',
      penulis: 'Nadia Fitriani',
      deskripsi:
          'Laporan ini mencakup hasil, tantangan, dan keberhasilan dari kegiatan hackathon yang telah diadakan. Dokumen ini memberikan gambaran lengkap tentang dampak dan manfaat hackathon terhadap peserta dan komunitas Teknik Informatika.',
      assetPath: 'assets/pdf/laporan_hackathon_ti.pdf',
    ),

    PdfEntity(
      id: '7',
      judul:
          'Proposal Seminar Workshop: Strategi Keamanan Siber di Era Digital',
      penulis: 'Aulia Rahman',
      deskripsi:
          'Proposal ini memaparkan rencana pelaksanaan seminar dan workshop mengenai strategi keamanan siber di era digital. Kegiatan ini bertujuan untuk meningkatkan pemahaman mahasiswa Teknik Informatika tentang tantangan keamanan siber dan cara mengatasinya.',
      assetPath: 'assets/pdf/proposal_workshop_keamanan_siber.pdf',
    ),

    PdfEntity(
      id: '8',
      judul:
          'Laporan Pertanggungjawaban Seminar Workshop: Strategi Keamanan Siber di Era Digital',
      penulis: 'Rizky Pratama',
      deskripsi:
          'Laporan ini memberikan gambaran tentang pelaksanaan seminar dan workshop keamanan siber. Dokumen ini mencakup respons peserta, evaluasi kegiatan, dan rekomendasi untuk pengembangan kegiatan serupa di masa depan.',
      assetPath: 'assets/pdf/laporan_workshop_keamanan_siber.pdf',
    ),

    PdfEntity(
      id: '9',
      judul: 'Proposal Kegiatan Sosial: Coding for Charity',
      penulis: 'Diana Utami',
      deskripsi:
          'Proposal ini berfokus pada kegiatan sosial "Coding for Charity" yang melibatkan mahasiswa Teknik Informatika dalam pengembangan solusi teknologi untuk membantu organisasi nirlaba. Kegiatan ini bertujuan untuk mengintegrasikan pemrograman dengan misi sosial positif.',
      assetPath: 'assets/pdf/proposal_coding_for_charity.pdf',
    ),

    PdfEntity(
      id: '10',
      judul: 'Laporan Pertanggungjawaban Kegiatan Sosial: Coding for Charity',
      penulis: 'Faisal Ramadhan',
      deskripsi:
          'Laporan ini merinci dampak positif dari kegiatan sosial "Coding for Charity". Dokumen ini memuat hasil kerja tim, keberhasilan solusi yang dikembangkan, dan efek positif pada komunitas yang dilayani.',
      assetPath: 'assets/pdf/laporan_coding_for_charity.pdf',
    ),

    // Add more realistic data as needed
  ];

  Future<List<PdfEntity>> getPdfList() async {
    // For dummy data, return the list of PdfEntity
    return _pdfList;
  }
}
