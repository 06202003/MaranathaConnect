// data/datasources/image_proker_datasource.dart

class ProgramKerja {
  final String nama;
  final String imagePath;

  ProgramKerja(this.nama, this.imagePath);
}

List<ProgramKerja> programKerjaList = [
  ProgramKerja('Studi Banding HMPSTIF UNPAR', 'assets/proker/proker1.JPG'),
  ProgramKerja('POR & PES IT', 'assets/proker/proker2.JPG'),
  ProgramKerja('Google Devfest 2023', 'assets/proker/proker3.jpg'),
  ProgramKerja('Integer 2023', 'assets/proker/proker4.JPG'),
  ProgramKerja('Charity', 'assets/proker/proker5.jpg'),
  ProgramKerja('SemafitTalks', 'assets/proker/proker6.png'),
  ProgramKerja('Malam Keakraban SEMAFIT', 'assets/proker/proker7.jpg'),
  ProgramKerja('Insight IT Lenmarc', 'assets/proker/proker8.JPG'),
  // Add more ProgramKerja objects as needed
];
